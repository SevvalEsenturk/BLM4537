using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

// Buradaki AppDbContext adının, Data/AppDbContext.cs dosyanızdaki sınıf adıyla eşleştiğinden emin olun.
public class AppDbContextFactory : IDesignTimeDbContextFactory<AppDbContext>
{
    public AppDbContext CreateDbContext(string[] args)
    {
        // Bu metod sadece dotnet ef (migrations, database update) komutları tarafından kullanılır.
        
        var optionsBuilder = new DbContextOptionsBuilder<AppDbContext>();
        
        // ❗ ÖNEMLİ: Connection string'i buraya kopyalayın
        // appsettings.json dosyanızdaki "DefaultConnection" ile aynı olmalı.
        var connectionString = "Host=localhost;Port=5432;Database=lockapp_db;Username=postgres;Password=your_password";

        optionsBuilder.UseNpgsql(connectionString);

        return new AppDbContext(optionsBuilder.Options);
    }
}