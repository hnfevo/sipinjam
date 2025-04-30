# SiPinjam

![Flutter](https://img.shields.io/badge/Flutter-Enabled-blue?logo=flutter)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

Repository Flutter untuk aplikasi **SiPinjam**.

---

## 📋 Prasyarat

Sebelum menjalankan project ini, pastikan kamu sudah menginstal:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/) (dengan extension Flutter & Dart)
- Emulator Android atau perangkat fisik
- (Opsional) Xcode untuk build di iOS (hanya di macOS)

Cek apakah instalasi sudah benar:
```bash
flutter doctor
```

---

## 🚀 Cara Menjalankan Project

1. **Clone repository ini**
   ```bash
   git clone https://github.com/hnfevo/sipinjam.git
   cd sipinjam
   ```

2. **Install semua dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   - Pastikan device/emulator sudah terhubung
   - Jalankan perintah berikut:
     ```bash
     flutter run
     ```

4. **(Opsional) Build untuk Web**
   Jika ingin menjalankan di browser:
   ```bash
   flutter run -d chrome
   ```

---

## 📁 Struktur Folder

| Folder    | Deskripsi                     |
|-----------|--------------------------------|
| `lib/`    | Source code utama aplikasi     |
| `assets/` | File gambar, font, dll          |
| `android/`| Konfigurasi Android native     |
| `ios/`    | Konfigurasi iOS native         |
| `web/`    | Konfigurasi versi web          |
| `test/`   | Unit test dan widget test      |

---

## 🛠️ Catatan Tambahan

- Pastikan tidak ada error di file `pubspec.yaml`.
- Jika ada error permission/build, jalankan:
  ```bash
  flutter clean
  flutter pub get
  ```
- Untuk update Flutter ke versi terbaru:
  ```bash
  flutter upgrade
  ```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
