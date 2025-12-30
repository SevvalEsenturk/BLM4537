namespace LockApp.Api.Dtos
{
    public record RegisterDto(string Name, string Email, string Password, string Role);
    public record LoginDto(string Email, string Password);
    public record LoginResponseDto(string Token, int Id, string Name, string Email, string Role);
    public record UpdateProfileDto(string Name, string Email);
    public record ChangePasswordDto(string OldPassword, string NewPassword);
}
