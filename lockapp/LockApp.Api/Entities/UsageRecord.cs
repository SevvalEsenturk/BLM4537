using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LockApp.Api.Entities
{
    public class UsageRecord
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int ChildUserId { get; set; }

        [Required]
        [MaxLength(100)]
        public string AppName { get; set; }

        [Required]
        public int UsageMinutes { get; set; }

        public string AppCategory { get; set; } // e.g., "Game", "Social", "Education"

        [Required]
        public DateTime RecordDate { get; set; }

        [ForeignKey(nameof(ChildUserId))]
        public virtual User ChildUser { get; set; }
    }
}
