namespace LockApp.Api.Entities;

public class AppBlockRule
{
    public int Id { get; set; }
    public int ParentUserId { get; set; }
    public int ChildUserId { get; set; }
    public string PackageName { get; set; } = string.Empty;
    public string AppName { get; set; } = string.Empty;
    public bool IsBlocked { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}
