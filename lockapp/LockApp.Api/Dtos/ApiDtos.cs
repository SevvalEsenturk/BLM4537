namespace LockApp.Api.Dtos
{
    public record PairingRequestDto(int ParentUserId, int ChildUserId, string Code, string DeviceName, string DeviceType);
    public record TimeRuleDto(int DailyLimitMinutes, TimeSpan? AllowedWindowStart, TimeSpan? AllowedWindowEnd, string ActiveDaysJson, string ExceptionsJson);
    public record UsageRecordDto(int ChildUserId, string AppName, int UsageMinutes, string AppCategory, DateTime? RecordDate);
}
