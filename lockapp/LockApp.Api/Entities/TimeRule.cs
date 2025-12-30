using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LockApp.Api.Entities
{
    public class TimeRule
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int ChildUserId { get; set; }

        [Required]
        public int DailyLimitMinutes { get; set; } // -1 = unlimited

        public TimeSpan? AllowedWindowStart { get; set; } // e.g., 14:00

        public TimeSpan? AllowedWindowEnd { get; set; } // e.g., 22:00

        public string ActiveDaysJson { get; set; } // JSON array: ["Monday","Tuesday",...] or null = every day

        public string ExceptionsJson { get; set; } // JSON array of dates when rule doesn't apply

        [Required]
        public bool IsActive { get; set; } = true;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? UpdatedAt { get; set; }

        [ForeignKey(nameof(ChildUserId))]
        public virtual User ChildUser { get; set; }
    }
}
