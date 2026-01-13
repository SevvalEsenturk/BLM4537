namespace LockApp.Api.Entities
{
    public class Device
    {
        public int Id { get; set; }          // PK
        public string Name { get; set; } = null!;
        public string Os { get; set; } = null!;      // işletim sistemi
        public DateTime CreatedAt { get; set; }
        public string DeviceId { get; set; }  = null!; // device id / unique id
        public int UserId { get; set; }       // Sahibi olan User (FK)
        public User User { get; set; } = null!;
        public bool IsBlocked { get; set; }   // Cihaz şu an kilitli mi?
        public DateTime? LastSeenAt { get; set; } // En son ne zaman online oldu

    }
}
