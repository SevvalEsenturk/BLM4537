using Microsoft.EntityFrameworkCore;
using LockApp.Api.Data;
using Microsoft.EntityFrameworkCore.Design;

namespace LockApp.Api
{
    public class AppDbContextFactory : IDesignTimeDbContextFactory<AppDbContext>
    {
        public AppDbContext CreateDbContext(string[] args)
        {            
            var optionsBuilder = new DbContextOptionsBuilder<AppDbContext>();
            
            var connectionString = "Host=localhost;Port=5432;Database=lockapp_db;Username=postgres;Password=pikachu2029";

            optionsBuilder.UseNpgsql(connectionString);

            return new AppDbContext(optionsBuilder.Options);
        }
    }
}