# MIXER DJooN — By BohlamSunarya

Digital audio mixer berbasis Web Audio API dengan tampilan konsol 24 channel yang terinspirasi dari referensi yang diberikan. Proyek ini menggunakan satu UI web bersama, dibungkus dengan Electron untuk Windows dan Capacitor untuk Android.

## Fitur yang diimplementasikan

- 24 channel strip, nama channel dapat diedit, input file audio dan mikrofon (jika browser/perangkat mengizinkan).
- Channel gain, pan, fader, polarity invert, Solo, Mute, output routing ke MASTER LR / GROUP A / GROUP B.
- Parametric EQ empat band per channel: frekuensi 20 Hz–20 kHz, gain ±12 dB, dan Q 0,3–12.
- High-pass filter, noise gate berbasis level input, compressor per channel dengan threshold, ratio, attack, dan release.
- Dua subgroup, fader, mute, compressor subgroup, dan meter.
- AUX 1/2 send/return; empat FX send/return (convolution reverb, delay dengan feedback, chorus via modulated delay, slapback).
- Empat DCA group dengan level, mute, dan assignment per channel.
- Master fader, mute, compressor/limiter, meter level, indikator clipping, dan spektrum FFT real-time 20 Hz–20 kHz dengan peak hold.
- Master recording melalui MediaRecorder (WebM/Opus jika didukung browser).
- Ekspor proyek `.djoon.json` yang menyematkan audio asset dalam data URL, impor proyek, penyimpanan scene lokal, serta ekspor konfigurasi JSON.
- Tombol POWER ON/OFF untuk audio engine.

## Jalankan tanpa instalasi

1. Buka `index.html` di Chrome atau Edge modern.
2. Tekan **POWER ON** untuk membuat AudioContext.
3. Tekan **FILE** pada channel, pilih audio, lalu **PLAY**.
4. Untuk mikrofon, tekan **MIC** dan izinkan akses microphone.
5. Untuk menyimpan proyek lengkap, gunakan **SAVE PROJECT**. File akan menyertakan audio yang telah dimuat dan bisa berukuran besar.

Mikrofon umumnya memerlukan secure context (misalnya localhost, file origin yang diizinkan browser, Electron, atau aplikasi Android dengan izin yang sesuai). Jika mikrofon tidak aktif dari `file://`, jalankan versi Electron atau server lokal.

## Windows EXE (Electron)

Persyaratan:
- Windows 10/11 64-bit
- Node.js LTS dan npm
- Koneksi internet saat pertama kali memasang dependency

Langkah:
1. Ekstrak folder proyek.
2. Klik dua kali `Build_Windows_EXE.bat`, atau jalankan dari terminal:

   ```powershell
   npm install
   npm run dist:win
   ```

3. Artefak akan muncul di folder `dist/`: installer NSIS dan executable portable.
4. Setelah dependency terpasang, jalankan `Start_MIXER_DJooN.bat` untuk membuka app Electron. Jika Electron belum terpasang, launcher membuka `index.html` di browser.

## Android APK (Capacitor)

Persyaratan:
- Windows dengan Android Studio + Android SDK (Platform Tools dan Build Tools), JDK yang kompatibel, Node.js LTS
- Koneksi internet pada build pertama untuk mengunduh dependency Gradle/npm

Langkah:
1. Buka folder proyek di Windows.
2. Klik `Build_Android_APK.bat`, atau jalankan:

   ```powershell
   npm install
   npm run android:init
   npm run apk:debug
   ```

3. APK debug akan dibuat di `android/app/build/outputs/apk/debug/app-debug.apk`.
4. Untuk rilis, siapkan signing key lalu gunakan `npm run apk:release`; APK release dari Gradle perlu ditandatangani sebelum distribusi publik.
5. Untuk akses mikrofon, pastikan permission `RECORD_AUDIO` dan `MODIFY_AUDIO_SETTINGS` ada di `android/app/src/main/AndroidManifest.xml` (lihat `android-notes/AndroidManifest.permission-snippet.xml`) dan uji dialog izin runtime pada perangkat Android.

`npm run android:init` membuat folder native `android/` untuk pertama kali. Folder itu sengaja tidak disertakan dalam source ZIP agar paket lebih kecil dan bisa dibuat sesuai versi SDK lokal.

## Struktur proyek

```text
MIXER_DJooN_PRO/
├── index.html                    # UI dan audio engine bersama
├── package.json                 # Dependency dan build Electron/Capacitor
├── capacitor.config.json        # Konfigurasi aplikasi Android
├── electron/main.cjs            # Desktop window aman
├── scripts/build-web.cjs        # Salin HTML ke www/ untuk Capacitor
├── scripts/build-android.cjs    # Jalankan Gradle wrapper untuk APK
├── Start_MIXER_DJooN.bat        # Launcher Windows
├── Build_Windows_EXE.bat        # Build installer + portable EXE
├── Build_Android_APK.bat        # Inisialisasi dan build APK debug
└── android-notes/               # Catatan permission Android
```

## Batasan yang perlu diketahui

- Project ini menyediakan source dan skrip build; EXE/APK harus dikompilasi pada komputer dengan toolchain yang sesuai. Paket sumber tidak mengklaim bahwa binary native telah dibangun.
- Pemrosesan dilakukan melalui Web Audio API. Latensi, kualitas driver, jumlah input fisik simultan, dan dukungan mikrofon bergantung pada browser/WebView, OS, serta perangkat audio.
- Gate adalah gate berbasis level yang diperbarui secara real-time, bukan expander/gate DSP khusus dengan side-chain eksternal.
- FX dan compressor adalah implementasi perangkat lunak ringan; ini bukan pengganti seluruh fitur mixer hardware kelas atas.
- Proyek yang menyertakan audio akan besar karena aset disimpan dalam JSON. Gunakan file sumber audio yang wajar untuk menghindari penggunaan memori berlebihan.
- Uji semua routing, monitoring, izin mikrofon, dan rekaman pada perangkat target sebelum penggunaan live.
