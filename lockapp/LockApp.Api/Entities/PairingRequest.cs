using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LockApp.Api.Entities
{
    public class PairingRequest
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int ParentUserId { get; set; }

        [Required]
        public int ChildUserId { get; set; }

        [Required]
        [MaxLength(10)]
        public string PairingCode { get; set; }

        [Required]
        [MaxLength(50)]
        public string DeviceName { get; set; }

        [Required]
        [MaxLength(20)]
        public string DeviceType { get; set; } // "web", "android", "ios"

        [Required]
        [MaxLength(20)]
        public string Status { get; set; } = "Pending"; // Pending, Approved, Rejected

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? ExpiresAt { get; set; }

        public DateTime? ApprovedAt { get; set; }

        [ForeignKey(nameof(ParentUserId))]
        public virtual User ParentUser { get; set; }

        [ForeignKey(nameof(ChildUserId))]
        public virtual User ChildUser { get; set; }
    }
}
