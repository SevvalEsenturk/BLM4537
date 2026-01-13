using LockApp.Api.Data;
using LockApp.Api.Dtos;
using LockApp.Api.Entities;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;
using System.Text.Json;
using Microsoft.AspNetCore.Http.Json;
using BCrypt.Net;

var builder = WebApplication.CreateBuilder(args);

// JSON camelCase support
builder.Services.Configure<JsonOptions>(options =>
{
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    options.SerializerOptions.PropertyNameCaseInsensitive = true;
});

// SQLite + DbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlite(
        builder.Configuration.GetConnectionString("DefaultConnection")
    )
);

// Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// Swagger UI
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");

// ================== AUTH ENDPOINTS ==================

app.MapPost("/api/auth/register", async (RegisterDto dto, AppDbContext db) =>
{
    if (await db.Users.AnyAsync(u => u.Email == dto.Email))
        return Results.BadRequest("Email already exists");

    var user = new User
    {
        Name = dto.Name,
        Email = dto.Email,
        PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.Password),
        Role = dto.Role, // "Parent" or "Child"
        CreatedAt = DateTime.UtcNow,
        UpdatedAt = DateTime.UtcNow
    };

    db.Users.Add(user);
    await db.SaveChangesAsync();

    return Results.Created($"/api/users/{user.Id}", new { id = user.Id, email = user.Email });
})
.WithName("Register")
.WithOpenApi();

app.MapPost("/api/auth/login", async (LoginDto dto, AppDbContext db) =>
{
    var user = await db.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
    if (user == null || !BCrypt.Net.BCrypt.Verify(dto.Password, user.PasswordHash))
        return Results.Unauthorized();

    // In a real app, generate JWT here. For now, return the user info.
    return Results.Ok(new LoginResponseDto("dummy-token", user.Id, user.Name, user.Email, user.Role));
})
.WithName("Login")
.WithOpenApi();

// ================== USER ENDPOINTLERİ ==================

// Tüm kullanıcılar
app.MapGet("/api/users", async (AppDbContext db) =>
    await db.Users.ToListAsync()
);
app.MapGet("/api/devices", async (AppDbContext db) =>
    await db.Devices.ToListAsync()
);

// Id ile tek kullanıcı
app.MapGet("/api/users/{id:int}", async (int id, AppDbContext db) =>
{
    var user = await db.Users.FindAsync(id);
    return user is null ? Results.NotFound() : Results.Ok(user);
});

// Yeni kullanıcı ekle
app.MapPost("/api/users", async (User user, AppDbContext db) =>
{
    user.CreatedAt = DateTime.UtcNow;
    user.UpdatedAt = DateTime.UtcNow;

    db.Users.Add(user);
    await db.SaveChangesAsync();

    return Results.Created($"/api/users/{user.Id}", user);
});

// Kullanıcı Profil Güncelleme
app.MapPut("/api/users/{id}/profile", async (int id, UpdateProfileDto dto, AppDbContext db) =>
{
    var user = await db.Users.FindAsync(id);
    if (user is null) return Results.NotFound();

    user.Name = dto.Name;
    user.Email = dto.Email;
    user.UpdatedAt = DateTime.UtcNow;

    await db.SaveChangesAsync();

    return Results.Ok(user);
})
.WithName("UpdateProfile")
.WithOpenApi();

// Şifre Değiştirme
app.MapPost("/api/users/{id}/change-password", async (int id, ChangePasswordDto dto, AppDbContext db) =>
{
    var user = await db.Users.FindAsync(id);
    if (user is null) return Results.NotFound();

    if (!BCrypt.Net.BCrypt.Verify(dto.OldPassword, user.PasswordHash))
        return Results.BadRequest("Old password is incorrect");

    user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(dto.NewPassword);
    user.UpdatedAt = DateTime.UtcNow;

    await db.SaveChangesAsync();

    return Results.Ok(new { message = "Password changed successfully" });
})
.WithName("ChangePassword")
.WithOpenApi();

/* DEPRECATED OLD UPDATE
app.MapPut("/api/users/{id:int}", async (int id, User updated, AppDbContext db) =>
{
   // ...
});
*/

// ==================== PAIRING ENDPOINTS ====================

app.MapPost("/api/pairing/create-code", (int parentId, HttpContext context) =>
{
    var code = GenerateRandomCode(6);
    var expiresAt = DateTime.UtcNow.AddMinutes(10);
    
    var response = new
    {
        code = code,
        expiresAt = expiresAt,
        message = "QR code generated. Share this with the child."
    };
    
    return Results.Ok(response);
})
.WithName("CreatePairingCode")
.WithOpenApi();

app.MapPost("/api/pairing/request", async (PairingRequestDto dto, AppDbContext db) =>
{
    var parentUser = await db.Users.FindAsync(dto.ParentUserId);
    var childUser = await db.Users.FindAsync(dto.ChildUserId);

    if (parentUser == null || childUser == null)
        return Results.NotFound("Parent or child user not found");

    var expiresAt = DateTime.UtcNow.AddMinutes(10);
    var pairing = new PairingRequest
    {
        ParentUserId = dto.ParentUserId,
        ChildUserId = dto.ChildUserId,
        PairingCode = dto.Code,
        DeviceName = dto.DeviceName,
        DeviceType = dto.DeviceType,
        Status = "Pending",
        CreatedAt = DateTime.UtcNow,
        ExpiresAt = expiresAt
    };

    db.PairingRequests.Add(pairing);
    await db.SaveChangesAsync();

    return Results.Created($"/api/pairing/{pairing.Id}", new
    {
        id = pairing.Id,
        status = pairing.Status,
        createdAt = pairing.CreatedAt
    });
})
.WithName("SubmitPairingRequest")
.WithOpenApi();

app.MapGet("/api/pairing/pending", async (int parentId, AppDbContext db) =>
{
    var pending = await db.PairingRequests
        .Where(p => p.ParentUserId == parentId && p.Status == "Pending")
        .Include(p => p.ChildUser)
        .OrderByDescending(p => p.CreatedAt)
        .Select(p => new
        {
            id = p.Id,
            childId = p.ChildUserId,
            childName = p.ChildUser.Name,
            deviceName = p.DeviceName,
            deviceType = p.DeviceType,
            createdAt = p.CreatedAt,
            expiresAt = p.ExpiresAt
        })
        .ToListAsync();

    return Results.Ok(pending);
})
.WithName("GetPendingPairingRequests")
.WithOpenApi();

app.MapPost("/api/pairing/{requestId}/approve", async (int requestId, AppDbContext db) =>
{
    var pairing = await db.PairingRequests.FindAsync(requestId);
    if (pairing == null)
        return Results.NotFound();

    var childUser = await db.Users.FindAsync(pairing.ChildUserId);
    if (childUser == null)
        return Results.NotFound();

    pairing.Status = "Approved";
    pairing.ApprovedAt = DateTime.UtcNow;
    childUser.ParentUserId = pairing.ParentUserId;

    await db.SaveChangesAsync();

    return Results.Ok(new { status = "Approved", approvedAt = pairing.ApprovedAt });
})
.WithName("ApprovePairingRequest")
.WithOpenApi();

app.MapPost("/api/pairing/{requestId}/reject", async (int requestId, AppDbContext db) =>
{
    var pairing = await db.PairingRequests.FindAsync(requestId);
    if (pairing == null)
        return Results.NotFound();

    pairing.Status = "Rejected";
    await db.SaveChangesAsync();

    return Results.Ok(new { status = "Rejected" });
})
.WithName("RejectPairingRequest")
.WithOpenApi();

// ==================== TIME RULES ENDPOINTS ====================

app.MapGet("/api/rules/{childId}", async (int childId, AppDbContext db) =>
{
    var rule = await db.TimeRules
        .FirstOrDefaultAsync(r => r.ChildUserId == childId && r.IsActive);

    if (rule == null)
        return Results.NotFound();

    return Results.Ok(new
    {
        id = rule.Id,
        childId = rule.ChildUserId,
        dailyLimitMinutes = rule.DailyLimitMinutes,
        allowedWindowStart = rule.AllowedWindowStart,
        allowedWindowEnd = rule.AllowedWindowEnd,
        activeDaysJson = rule.ActiveDaysJson,
        exceptionsJson = rule.ExceptionsJson,
        isActive = rule.IsActive,
        updatedAt = rule.UpdatedAt
    });
})
.WithName("GetTimeRule")
.WithOpenApi();

app.MapPut("/api/rules/{childId}", async (int childId, TimeRuleDto dto, AppDbContext db) =>
{
    var rule = await db.TimeRules
        .FirstOrDefaultAsync(r => r.ChildUserId == childId);

    if (rule == null)
    {
        rule = new TimeRule
        {
            ChildUserId = childId,
            DailyLimitMinutes = dto.DailyLimitMinutes,
            AllowedWindowStart = dto.AllowedWindowStart,
            AllowedWindowEnd = dto.AllowedWindowEnd,
            ActiveDaysJson = dto.ActiveDaysJson,
            ExceptionsJson = dto.ExceptionsJson,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        };
        db.TimeRules.Add(rule);
    }
    else
    {
        rule.DailyLimitMinutes = dto.DailyLimitMinutes;
        rule.AllowedWindowStart = dto.AllowedWindowStart;
        rule.AllowedWindowEnd = dto.AllowedWindowEnd;
        rule.ActiveDaysJson = dto.ActiveDaysJson;
        rule.ExceptionsJson = dto.ExceptionsJson;
        rule.UpdatedAt = DateTime.UtcNow;
    }

    await db.SaveChangesAsync();
    return Results.Ok(new { id = rule.Id, status = "saved" });
})
.WithName("UpsertTimeRule")
.WithOpenApi();

// ==================== USAGE ENDPOINTS ====================

app.MapPost("/api/usage", async (UsageRecordDto dto, AppDbContext db) =>
{
    var record = new UsageRecord
    {
        ChildUserId = dto.ChildUserId,
        AppName = dto.AppName,
        UsageMinutes = dto.UsageMinutes,
        AppCategory = dto.AppCategory,
        RecordDate = dto.RecordDate ?? DateTime.UtcNow
    };

    db.UsageRecords.Add(record);
    await db.SaveChangesAsync();

    return Results.Created($"/api/usage/{record.Id}", record);
})
.WithName("CreateUsageRecord")
.WithOpenApi();

app.MapGet("/api/usage/summary", async (int childId, string range, AppDbContext db) =>
{
    var now = DateTime.UtcNow;
    var startDate = range == "weekly"
        ? now.AddDays(-7)
        : now.AddDays(-1);

    var totalMinutes = await db.UsageRecords
        .Where(u => u.ChildUserId == childId && u.RecordDate >= startDate)
        .SumAsync(u => u.UsageMinutes);

    return Results.Ok(new
    {
        childId = childId,
        range = range,
        totalMinutes = totalMinutes,
        startDate = startDate,
        endDate = now
    });
})
.WithName("GetUsageSummary")
.WithOpenApi();

app.MapGet("/api/usage/topapps", async (int childId, string range, AppDbContext db) =>
{
    var now = DateTime.UtcNow;
    var startDate = range == "weekly"
        ? now.AddDays(-7)
        : now.AddDays(-1);

    var topApps = await db.UsageRecords
        .Where(u => u.ChildUserId == childId && u.RecordDate >= startDate)
        .GroupBy(u => u.AppName)
        .Select(g => new
        {
            appName = g.Key,
            totalMinutes = g.Sum(u => u.UsageMinutes),
            category = g.First().AppCategory
        })
        .OrderByDescending(x => x.totalMinutes)
        .Take(5)
        .ToListAsync();

    return Results.Ok(topApps);
})
.WithName("GetTopApps")
.WithOpenApi();

// ==================== NOTIFICATIONS ENDPOINTS ====================

app.MapGet("/api/notifications", async (int userId, AppDbContext db) =>
{
    var notifications = await db.NotificationLogs
        .Where(n => n.UserId == userId)
        .OrderByDescending(n => n.CreatedAt)
        .Take(20)
        .Select(n => new
        {
            id = n.Id,
            title = n.Title,
            message = n.Message,
            type = n.Type,
            isRead = n.IsRead,
            createdAt = n.CreatedAt
        })
        .ToListAsync();

    return Results.Ok(notifications);
})
.WithName("GetNotifications")
.WithOpenApi();

// ==================== APP BLOCK RULES ENDPOINTS ====================

app.MapGet("/api/block-rules/{childId}", async (int childId, AppDbContext db) =>
{
    var rules = await db.AppBlockRules
        .Where(r => r.ChildUserId == childId && r.IsBlocked)
        .OrderByDescending(r => r.CreatedAt)
        .ToListAsync();

    return Results.Ok(rules);
})
.WithName("GetBlockRules")
.WithOpenApi();

app.MapPost("/api/block-rules", async (AppBlockRule rule, AppDbContext db) =>
{
    // Check if parent and child exist
    var parentExists = await db.Users.AnyAsync(u => u.Id == rule.ParentUserId);
    var childExists = await db.Users.AnyAsync(u => u.Id == rule.ChildUserId);

    if (!parentExists || !childExists)
        return Results.NotFound("Parent or child user not found");

    // Check if rule already exists for this package
    var existingRule = await db.AppBlockRules
        .FirstOrDefaultAsync(r => r.ChildUserId == rule.ChildUserId && r.PackageName == rule.PackageName);

    if (existingRule != null)
    {
        existingRule.IsBlocked = rule.IsBlocked;
        existingRule.AppName = rule.AppName; // Update name in case it changed
        existingRule.UpdatedAt = DateTime.UtcNow;
    }
    else
    {
        rule.CreatedAt = DateTime.UtcNow;
        rule.UpdatedAt = DateTime.UtcNow;
        db.AppBlockRules.Add(rule);
    }

    await db.SaveChangesAsync();
    return Results.Ok(existingRule ?? rule);
})
.WithName("UpsertBlockRule")
.WithOpenApi();

app.MapDelete("/api/block-rules/{id}", async (int id, AppDbContext db) =>
{
    var rule = await db.AppBlockRules.FindAsync(id);
    if (rule is null) return Results.NotFound();

    db.AppBlockRules.Remove(rule);
    await db.SaveChangesAsync();

    return Results.Ok(new { message = "Rule deleted" });
})
.WithName("DeleteBlockRule")
.WithOpenApi();

// ==================== HELPER ====================

static string GenerateRandomCode(int length)
{
    const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var random = new Random();
    return new string(Enumerable.Range(0, length)
        .Select(_ => chars[random.Next(chars.length)])
        .ToArray());
}

app.Run();
