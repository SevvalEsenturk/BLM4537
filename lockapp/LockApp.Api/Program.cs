using LockApp.Api.Data;
using LockApp.Api.Entities;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// PostgreSQL + DbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("DefaultConnection")
    )
);

// Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Swagger UI
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

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

// Kullanıcı güncelle (basit örnek)
app.MapPut("/api/users/{id:int}", async (int id, User updated, AppDbContext db) =>
{
    var user = await db.Users.FindAsync(id);
    if (user is null) return Results.NotFound();

    user.Name = updated.Name;
    user.Email = updated.Email;
    user.Role = updated.Role;
    user.UpdatedAt = DateTime.UtcNow;

    await db.SaveChangesAsync();

    return Results.Ok(user);
});

app.Run();
