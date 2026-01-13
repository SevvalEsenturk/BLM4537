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
        public DbSet<PairingRequest> PairingRequests { get; set; } = null!;
        public DbSet<TimeRule> TimeRules { get; set; } = null!;
        public DbSet<UsageRecord> UsageRecords { get; set; } = null!;
        public DbSet<NotificationLog> NotificationLogs { get; set; } = null!;
        public DbSet<AppBlockRule> AppBlockRules { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<AppBlockRule>(entity =>
            {
                entity.ToTable("AppBlockRules");
                entity.HasKey(e => e.Id);
            });

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

            // PairingRequest relationships
            modelBuilder.Entity<PairingRequest>(entity =>
            {
                entity.ToTable("PairingRequests");
                entity.HasKey(p => p.Id);

                entity.HasOne(p => p.ParentUser)
                    .WithMany()
                    .HasForeignKey(p => p.ParentUserId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(p => p.ChildUser)
                    .WithMany()
                    .HasForeignKey(p => p.ChildUserId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // TimeRule relationships
            modelBuilder.Entity<TimeRule>(entity =>
            {
                entity.ToTable("TimeRules");
                entity.HasKey(t => t.Id);

                entity.HasOne(t => t.ChildUser)
                    .WithMany()
                    .HasForeignKey(t => t.ChildUserId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // UsageRecord relationships
            modelBuilder.Entity<UsageRecord>(entity =>
            {
                entity.ToTable("UsageRecords");
                entity.HasKey(u => u.Id);

                entity.HasOne(u => u.ChildUser)
                    .WithMany()
                    .HasForeignKey(u => u.ChildUserId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // NotificationLog relationships
            modelBuilder.Entity<NotificationLog>(entity =>
            {
                entity.ToTable("NotificationLogs");
                entity.HasKey(n => n.Id);

                entity.HasOne(n => n.User)
                    .WithMany()
                    .HasForeignKey(n => n.UserId)
                    .OnDelete(DeleteBehavior.Cascade);
            });
        }
    }
}

