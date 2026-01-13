# LockApp - Akıllı Ebeveyn Denetim Sistemi 🛡️

**Ders Kodu:** BLM4537  
**Geliştirici:** Şevval Esentürk  

LockApp, ebeveynlerin çocuklarının dijital alışkanlıklarını yönetmelerine, uygulama kullanım sürelerini takip etmelerine ve zararlı olabilecek içerikleri engellemelerine olanak tanıyan, modern teknolojilerle geliştirilmiş kapsamlı bir ebeveyn denetim sistemidir.

## 🚀 Proje Özellikleri

Bu proje **Ebeveyn (Yönetici)** ve **Çocuk (Denetlenen)** olmak üzere iki farklı rolü tek bir uygulamada barındırır.

### 📱 Çocuk Modu (Android)
*   **Arka Plan Takibi:** Cihazda hangi uygulamanın ne kadar süreyle kullanıldığını saniye saniye takip eder.
*   **Uygulama Engelleme:** Ebeveyn tarafından yasaklanan uygulamalar açıldığında tespit edilir.
*   **QR Eşleştirme:** Ebeveyn cihazı ile güvenli ve hızlı eşleşme sağlar.
*   **Kullanım İzinleri:** Android `UsageStats` API kullanılarak sistem seviyesinde analiz yapar.

### 👨‍👩‍👧‍👦 Ebeveyn Modu (Mobil & Web)
*   **Canlı Raporlama:** Çocuğun hangi uygulamada kaç dakika geçirdiğini grafiklerle gösterir.
*   **Uzaktan Kontrol:** Tek tuşla istenen uygulamayı engelleme/engel kaldırma.
*   **Zaman Kısıtlaması:** Belirli saat aralıklarında cihaz kullanımını sınırlama (Geliştirme aşamasında).
*   **Çoklu Cihaz Yönetimi:** Birden fazla çocuğu aynı panelden yönetme.

## 🛠️ Kullanılan Teknolojiler

Proje **Full-Stack** bir mimariye sahiptir.

### Frontend (Mobil & Web)
*   **Framework:** [Flutter](https://flutter.dev/) (Dart)
*   **Platformlar:** Android (Öncelikli), Web, Windows
*   **Önemli Paketler:**
    *   `usage_stats`: Uygulama kullanım verilerini çekmek için.
    *   `device_apps`: Yüklü uygulamaları listelemek için.
    *   `qr_flutter` / `mobile_scanner`: Cihaz eşleştirme için.
    *   `http`: API haberleşmesi için.
    *   `permission_handler`: Android izin yönetimi için.

### Backend (Sunucu)
*   **Framework:** [.NET 8](https://dotnet.microsoft.com/) (ASP.NET Core Web API)
*   **Dil:** C#
*   **Veritabanı:** SQLite (Geliştirme ortamı), PostgreSQL (Prodüksiyon uyumlu)
*   **ORM:** Entity Framework Core (Code-First yaklaşımı)
*   **API:** RESTful mimari, Swagger/OpenAPI dokümantasyonu.

## 📂 Proje Yapısı

```bash
root/
├── lockapp/               # Flutter Mobil Uygulama (Frontend)
│   ├── lib/
│   │   ├── features/      # Özellik tabanlı modüller
│   │   ├── src/
│   │   │   ├── api/       # Backend servisleri
│   │   │   ├── services/  # Native servisler (AppBlocking, UsageStats)
│   │   │   └── screens/   # Arayüz ekranları
│   └── android/           # Native Android yapılandırmaları
│
└── LockApp.Api/           # .NET Backend API (Backend)
    ├── Controllers/       # (Minimal API kullanıldığı için Program.cs içinde tanımlı)
    ├── Entities/          # Veritabanı modelleri (AppBlockRule, UsageRecord...)
    ├── Data/              # DbContext
    └── Program.cs         # API Uçları ve Konfigürasyon
```

## ⚙️ Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için aşağıdaki adımları izleyin.

### 1. Backend'i Ayağa Kaldırma
Backend çalışmadan mobil uygulama veri alamaz.

```bash
cd lockapp/LockApp.Api
dotnet restore
dotnet run
```
*Backend varsayılan olarak `http://localhost:5200` adresinde çalışacaktır.*

### 2. Mobil Uygulamayı Çalıştırma (Android)
Çocuk modu özelliklerinin (engelleme, takip) çalışması için **Android cihaz veya Emülatör** gereklidir.

```bash
cd lockapp
flutter pub get
flutter run
```

### 3. Önemli: İzinlerin Verilmesi
Uygulama çocuk modunda ilk açıldığında **"Kullanım Erişimi İzni" (Usage Access Permission)** isteyecektir.
1.  Uygulama sizi ayarlara yönlendirecektir.
2.  Listeden **LockApp**'i bulup izni aktif edin.
3.  Bu izin olmadan kullanım takibi ve engelleme **ÇALIŞMAZ**.

## 📝 API Uçları (Endpoints)

*   `GET /api/users`: Kullanıcı listesi.
*   `POST /api/pairing/request`: Eşleştirme isteği.
*   `GET /api/block-rules/{childId}`: Engelleme kurallarını getir.
*   `POST /api/usage`: Kullanım istatistiklerini kaydet.

---
*Bu proje BLM4537 dersi kapsamında geliştirilmiştir.*
