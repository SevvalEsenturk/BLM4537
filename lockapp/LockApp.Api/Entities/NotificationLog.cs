using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LockApp.Api.Entities
{
    public class NotificationLog
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int UserId { get; set; }

        [Required]
        [MaxLength(100)]
        public string Title { get; set; }

        [Required]
        [MaxLength(500)]
        public string Message { get; set; }

        [Required]
        [MaxLength(30)]
        public string Type { get; set; } // "RuleLimitApproaching", "DailyLimitExceeded", "PairingRequest", "RuleAdded"

        [Required]
        public bool IsRead { get; set; } = false;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [ForeignKey(nameof(UserId))]
        public virtual User User { get; set; }
    }
}
