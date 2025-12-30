using System;

namespace LockApp.Api.Entities
{
    public class User
    {
        public int Id { get; set; }                     // PK

        public string Name { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string PasswordHash { get; set; } = string.Empty;

        public string Role { get; set; } = "Parent";    // örn: Parent / Child

        public int? ParentUserId { get; set; }          // Child'ın parent'ı

        public bool IsActive { get; set; } = true;

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }
    }
}
