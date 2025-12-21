https://github.com/user-attachments/assets/e73b3650-e8bc-4592-9aac-9413a642692f


🏠 Akıllı Ev Mobil Kontrol Arayüzü (Smart Home UI Prototype)

Bu proje, modern akıllı ev sistemleri için geliştirilmiş, kullanıcı deneyimi (UX) odaklı, minimalist ve modüler bir mobil arayüz prototipidir. Flutter ve Dart kullanılarak geliştirilen bu uygulama, IoT cihazlarının yönetimini görsel bir simülasyon üzerinden sunar.


 Proje Hakkında

Bu çalışma, karmaşık akıllı ev panellerini sadeleştirerek son kullanıcı için akıcı bir kontrol mekanizması sunmayı amaçlar. Proje, bir "Frontend" çalışması olup, gerçek veriler yerine Mock Data mimarisiyle sistemin çalışma mantığını simüle eder.
✨ Temel Özellikler

    Minimalist Tasarım: Kullanıcıyı yormayan Karanlık Tema (Dark Mode) konsepti.

    Modüler Yapı: SmartDeviceBox ile her cihaz için özelleştirilebilir, tekrar kullanılabilir widget mimarisi.

    Hero Animasyonları: Sayfa geçişlerinde akıcılığı sağlayan görsel geçiş efektleri.

    Dinamik Detay Sayfaları:

        Klima: Sıcaklık ve fan hızı kontrolü.

        Aydınlatma: Parlaklığa göre dinamik değişen arkaplan rengi (Color.lerp).

        Multimedya (TV): Netflix ve YouTube içerik listeleri, internetten veri çekme simülasyonu.

        Güvenlik: Anlık sensör takibi ve geçmiş olay günlükleri (Log).

    Responsive Tasarım: DevicePreview entegrasyonu ile farklı ekran boyutlarında kusursuz görünüm.




 Kullanılan Teknolojiler

    Framework: Flutter

    Dil: Dart

    Paketler: - google_fonts: Modern tipografi için.

        device_preview: Farklı ekranlarda test süreci için.

        cupertino_icons: iOS stili ikonlar için.




## 📂 Proje Yapısı
lib/
 ├── pages/
 │    ├── control_page.dart      # Cihaz detayları ve kontrol ekranı
 │    └── home_page.dart         # Ana sayfa ve cihaz listesi
 ├── util/
 │    └── smart_device_box.dart  # Modüler cihaz kutusu widget'ı
 └── main.dart                   # Uygulama başlangıcı ve tema ayarları



⚙️ Kurulum ve Çalıştırma

1)Projeyi kendi yerel ortamınızda çalıştırmak için:

    Bu depoyu klonlayın:

    git clone https://github.com/nilufereksi/Smart_Home_App

2)Proje dizinine gidin:

    cd (Smart_Home_App)


3)Bağımlılıkları yükleyin:

    flutter pub get

4)Uygulamayı başlatın:

    flutter run -d web-server --web-port 3000 
#ya da
    flutter run

5)Komut Paleti'ni açın-simple browser'ı seçin:(ctrl+shift+P)(macOS'te Cmd+Shift+P)

    http://localhost:3000



Geliştiren: [nilufereksi]

    

    




