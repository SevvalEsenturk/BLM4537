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
            
            var connectionString = "Data Source=lockapp.db";

            optionsBuilder.UseSqlite(connectionString);

            return new AppDbContext(optionsBuilder.Options);
        }
    }
}