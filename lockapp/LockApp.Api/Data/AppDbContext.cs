using LockApp.Api.Entities;
using Microsoft.EntityFrameworkCore;

namespace LockApp.Api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        // DbSet -> PostgreSQL'de oluşturulacak tablo
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<Device> Devices { get; set; } = null!; 

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("Users");

                entity.HasKey(u => u.Id);

                entity.Property(u => u.Name)
                      .IsRequired()
                      .HasMaxLength(100);

                entity.Property(u => u.Email)
                      .IsRequired()
                      .HasMaxLength(200);

                entity.Property(u => u.PasswordHash)
                      .IsRequired();

                entity.Property(u => u.Role)
                      .HasMaxLength(50);
            });
            modelBuilder.Entity<Device>(entity =>
    {
        entity.ToTable("Devices");

        entity.HasKey(d => d.Id);

        entity.Property(d => d.Name)
              .IsRequired()
            .HasMaxLength(100);

        entity.Property(d => d.Os)
              .IsRequired()
              .HasMaxLength(50);

        entity.Property(d => d.CreatedAt)
              .IsRequired();
    });
        }
    }
}

