class Promotion {
  final String id;
  final String imagePath;
  final String title;
  final String description;
  final String promoCode;
  final DateTime validUntil;
  final DateTime validFrom;
  final List<String> termsConditions;

  Promotion({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.promoCode,
    required this.validUntil,
    required this.validFrom,
    required this.termsConditions,
  });
}

final List<Promotion> promotions = [
  Promotion(
    id: 'promo1',
    imagePath: 'assets/banners/th2.jpeg',
    title: 'PROMO HUT BRI x Ruangguru!',
    description:
        '🎉 SPESIAL ULANG TAHUN BRI 🎉\n\n'
        'Rayakan momen spesial HUT Bank Rakyat Indonesia dengan investasi terbaik untuk masa depan: pendidikan berkualitas!\n\n'
        '💰 DISKON EKSKLUSIF 27% hingga Rp270.000 untuk:\n'
        '• Seluruh paket belajar Ruangguru Premium\n'
        '• Paket Skill Academy untuk pengembangan karir\n'
        '• Ruangguru Bootcamp teknologi & digital marketing\n'
        '• Program persiapan UTBK & masuk PTN favorit\n\n'
        '📱 CARA MENDAPATKAN:\n'
        '1. Pilih paket belajar favoritmu\n'
        '2. Masukkan kode: BRIJAYA27\n'
        '3. Lakukan pembayaran dengan kartu debit/kredit BRI\n'
        '4. Nikmati diskon langsung di halaman checkout!\n\n'
        '⏰ PERIODE PROMO:\n'
        'Berlaku hingga 31 Desember 2025\n'
        'Kuota terbatas untuk 1.000 pengguna pertama setiap minggunya\n\n'
        '❓ SYARAT & KETENTUAN:\n'
        '• Berlaku untuk semua jenis kartu BRI\n'
        '• Minimal transaksi Rp500.000\n'
        '• Maksimal diskon Rp270.000\n'
        '• Tidak dapat digabung dengan promo lainnya',
    promoCode: 'BRIJAYA27',
    validUntil: DateTime(2025, 7, 31),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Berlaku untuk semua jenis kartu BRI',
      'Minimal transaksi Rp500.000',
      'Maksimal diskon Rp270.000',
      'Tidak dapat digabung dengan promo lainnya',
      'Kuota terbatas untuk 1.000 pengguna pertama setiap minggunya'
    ],
  ),
  Promotion(
    id: 'promo2',
    imagePath: 'assets/banners/1.png',
    title: 'Brain Academy: Bimbel TER TER TER!',
    description:
        '✨ BRAIN ACADEMY: REVOLUSI CARA BELAJAR ✨\n\n'
        'Bimbel dengan 3 keunggulan SUPER yang tidak akan kamu temukan di tempat lain!\n\n'
        '💯 TERbaik dalam METODE PEMBELAJARAN:\n'
        '• Sistem pembelajaran berbasis cognitive science\n'
        '• Kurikulum disesuaikan dengan gaya belajar individual\n'
        '• Analisis kemampuan melalui AI untuk identifikasi kelemahan\n'
        '• Progress tracking mingguan dengan laporan detail\n'
        '• Garansi nilai meningkat minimal 20% atau uang kembali\n\n'
        '🌟 TERkeren dalam KUALITAS PENGAJAR:\n'
        '• Tim pengajar lulusan universitas top (UI, ITB, UGM, dll)\n'
        '• Minimal 5 tahun pengalaman mengajar\n'
        '• Sertifikasi internasional dalam bidangnya\n'
        '• Metode mengajar interaktif dan menyenangkan\n'
        '• Ratio pengajar dan siswa 1:8 untuk perhatian maksimal\n\n'
        '📚 TERlengkap dalam MATERI & FASILITAS:\n'
        '• 10.000+ video pembelajaran premium\n'
        '• 50.000+ bank soal terupdate sesuai kurikulum terbaru\n'
        '• E-book eksklusif untuk setiap mata pelajaran\n'
        '• Akses 24/7 ke platform belajar digital\n'
        '• Konsultasi PR unlimited via chat\n'
        '• Try out berkala dengan analisis hasil terperinci\n'
        '• Ruang belajar nyaman dengan fasilitas modern\n\n'
        '🏆 TESTIMONI SISWA KAMI:\n'
        '"Nilai matematika saya naik dari 65 jadi 92 dalam satu semester!" - Dina, kelas 11\n'
        '"Berhasil masuk ITB dengan program intensif Brain Academy!" - Rafi, alumni\n\n'
        '💲 PROMO PENDAFTARAN:\n'
        '• Diskon 30% untuk pendaftaran bulan ini\n'
        '• Gratis 4 sesi trial tanpa syarat\n'
        '• Cicilan 0% hingga 12 bulan',
    promoCode: 'BRAIN30',
    validUntil: DateTime(2025, 7, 26),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Diskon 30% untuk pendaftaran bulan ini',
      'Gratis 4 sesi trial tanpa syarat',
      'Cicilan 0% hingga 12 bulan',
      'Garansi nilai meningkat minimal 20% atau uang kembali'
    ],
  ),
  Promotion(
    id: 'promo3',
    imagePath: 'assets/banners/2.png',
    title: 'Belajar Bareng Idola Favoritmu!',
    description:
        '🤩 INSPIRASI BELAJAR DARI PARA BINTANG 🤩\n\n'
        'Siapa bilang belajar itu membosankan? Bergabunglah dengan idola-idola Indonesia yang telah memilih Ruangguru sebagai partner belajar mereka!\n\n'
        '🎬 BINTANG FILM & ENTERTAINMENT:\n'
        '• Iqbaal Ramadhan - Aktor, musisi, lulusan terbaik SMA\n'
        '  "Ruangguru membantu saya menyeimbangkan karir dan pendidikan"\n'
        '• Jefri Nichol - Aktor rising star Indonesia\n'
        '  "Dengan Ruangguru, saya bisa belajar di sela-sela syuting"\n'
        '• Maudy Ayunda - Artis multitalenta, lulusan Oxford & Stanford\n'
        '  "Aplikasi yang saya rekomendasikan untuk persiapan ujian"\n\n'
        '🎮 INFLUENCER & CONTENT CREATOR:\n'
        '• Jess No Limit - Pro gamer dengan jutaan followers\n'
        '  "Strategi belajar di Ruangguru mirip dengan strategi gaming!"\n'
        '• Atta Halilintar - YouTuber terpopuler di Indonesia\n'
        '  "Sukses bukan hanya tentang konten, tapi juga pendidikan"\n'
        '• Arief Muhammad - Entrepreneur & content creator\n'
        '  "Platform belajar yang saya andalkan untuk upgrade skills"\n\n'
        '🏆 ATLET & FIGUR INSPIRATIF:\n'
        '• Greysia Polii - Peraih medali olimpiade\n'
        '  "Disiplin belajar di Ruangguru seperti disiplin berlatih"\n'
        '• Fajri Zahir - Juara olimpiade matematika\n'
        '  "Tips-tips di Ruangguru sangat membantu persiapan kompetisi"\n\n'
        '📱 PROGRAM EKSKLUSIF:\n'
        '• "A Day With Stars" - kesempatan belajar langsung dengan idolamu\n'
        '• Webinar motivasi bulanan dengan para selebriti\n'
        '• Konten pembelajaran eksklusif yang dibawakan oleh para idola\n'
        '• Meet & greet virtual untuk 100 siswa terbaik setiap semester\n\n'
        '🔥 PROMO SPESIAL:\n'
        '• Diskon 25% dengan kode: IDOLAKU\n'
        '• Merchandise bertanda tangan idola untuk 50 pendaftar pertama\n'
        '• Kesempatan tampil di social media Ruangguru bersama idolamu',
    promoCode: 'IDOLAKU',
    validUntil: DateTime(2025, 7, 15),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Diskon 25% dengan kode: IDOLAKU',
      'Merchandise terbatas untuk 50 pendaftar pertama',
      'Kesempatan tampil di social media Ruangguru',
      'Berlaku untuk paket minimal 6 bulan'
    ],
  ),
  Promotion(
    id: 'promo4',
    imagePath: 'assets/banners/4.png',
    title: 'Fitur Video Belajar Baru di Ruangguru!',
    description:
        '🎬 REVOLUSI BELAJAR VISUAL TELAH TIBA! 🎬\n\n'
        'Ruangguru dengan bangga mempersembahkan FITUR VIDEO PEMBELAJARAN GENERASI BARU yang akan mengubah total cara kamu belajar!\n\n'
        '🔹 TEKNOLOGI PEMBELAJARAN MUTAKHIR:\n'
        '• Video kualitas Ultra HD (4K) dengan animasi motion graphics premium\n'
        '• Teknologi augmented reality untuk visualisasi konsep rumit\n'
        '• Interactive video dengan fitur "tap to explore" untuk pendalaman materi\n'
        '• Adaptive learning yang menyesuaikan konten berdasarkan gaya belajarmu\n'
        '• Visual effects Hollywood-grade untuk penjelasan sains dan matematika\n\n'
        '🔹 KONTEN SUPER LENGKAP:\n'
        '• 25.000+ video pembelajaran terstruktur\n'
        '• Mencakup semua mata pelajaran dari SD hingga SMA\n'
        '• Kurikulum nasional + internasional (IB, Cambridge, dll)\n'
        '• Materi persiapan PTN, UTBK, SBMPTN, dan ujian internasional\n'
        '• Konten pengayaan untuk olimpiade dan kompetisi akademik\n\n'
        '🔹 FITUR CERDAS & INOVATIF:\n'
        '• Smart search untuk menemukan penjelasan spesifik dalam video\n'
        '• Transcript otomatis dengan highlight keyword penting\n'
        '• Bookmark & notes yang tersinkronisasi dengan timeline video\n'
        '• Speed control (0.5x - 2x) tanpa distorsi suara\n'
        '• Mode hemat data untuk akses di area dengan sinyal terbatas\n'
        '• Download untuk belajar offline kapanpun dan dimanapun\n\n'
        '🔹 PEMBELAJARAN INTERAKTIF:\n'
        '• Quiz pop-up untuk mengukur pemahaman setiap 5 menit\n'
        '• Simulasi interaktif untuk eksperimen virtual\n'
        '• Latihan soal adaptif sesuai level pemahaman\n'
        '• Diskusi langsung dengan tutor melalui fitur "Ask in Video"\n'
        '• Ruang diskusi dengan sesama pelajar di setiap video\n\n'
        '🔹 TESTIMONI PENGGUNA:\n'
        '"Konsep fisika yang selama ini abstrak jadi sangat mudah dipahami!" - Dian, kelas 12\n'
        '"Video biologinya seperti documentary National Geographic!" - Rama, kelas 10\n'
        '"Nilai kimia organik saya naik drastis berkat animasi 3D-nya" - Putri, mahasiswa\n\n'
        '🔹 PROMO PELUNCURAN:\n'
        '• Akses gratis 7 hari untuk mencoba semua fitur premium\n'
        '• Diskon 40% untuk upgrade ke paket tahunan\n'
        '• Bonus 50 token untuk mengakses sesi konsultasi dengan master teacher',
    promoCode: 'VIDEOBARU',
    validUntil: DateTime(2025, 7, 17),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Akses gratis 7 hari untuk pengguna baru',
      'Diskon 40% untuk upgrade ke paket tahunan',
      'Bonus 50 token untuk sesi konsultasi',
      'Fitur AR hanya tersedia di perangkat tertentu'
    ],
  ),
  Promotion(
    id: 'promo5',
    imagePath: 'assets/banners/th.jpg',
    title: 'Promo GILA-GILAAN 55% OFF!',
    description:
        '💥 DISKON DAHSYAT YANG TIDAK MASUK AKAL! 💥\n\n'
        'PROMO TERBESAR SEPANJANG SEJARAH RUANGGURU!\n\n'
        '🔥 HANYA BAYAR SETENGAH, DAPAT SEGALANYA! 🔥\n\n'
        '💰 DETAIL PENAWARAN SUPER:\n'
        '• Harga normal: Rp775.000/tahun\n'
        '• Harga promo: CUMA Rp348.750/tahun!\n'
        '• Total penghematan: Rp426.250 (55% OFF!)\n'
        '• Akses penuh ke SEMUA fitur premium\n'
        '• Tidak ada biaya tersembunyi atau upgrade tambahan\n\n'
        '✨ YANG KAMU DAPATKAN:\n'
        '• Akses tak terbatas ke 100.000+ video pembelajaran\n'
        '• 350.000+ latihan soal dengan pembahasan lengkap\n'
        '• Tryout dan simulasi ujian nasional/masuk PTN\n'
        '• Konsultasi PR dengan master teacher (8 sesi/bulan)\n'
        '• Rangkuman materi digital untuk semua pelajaran\n'
        '• Akses ke Ruangguru Bootcamp selama 3 bulan\n'
        '• Live teaching session setiap minggu\n'
        '• Sertifikat digital untuk setiap kursus yang diselesaikan\n\n'
        '⚡ BONUS EKSKLUSIF:\n'
        '• E-book premium senilai Rp250.000\n'
        '• Akses gratis ke 12 webinar dengan pakar pendidikan\n'
        '• Ruangguru merchandise pack (notebook, pen, stiker, dll)\n'
        '• Voucher diskon 30% untuk perpanjangan tahun berikutnya\n\n'
        '⏰ BATAS WAKTU PROMO:\n'
        '• Mulai: 15 Juli 2018\n'
        '• DIPERPANJANG hingga: 29 Juli 2018 (23:59 WIB)\n'
        '• Status: MASIH BERLAKU! ✅\n'
        '• Kuota: Terbatas untuk 5.000 pendaftar\n'
        '• Sisa kuota: HAMPIR HABIS!\n\n'
        '💳 CARA MENDAPATKAN:\n'
        '1. Klik "DAFTAR SEKARANG"\n'
        '2. Pilih paket "ALL ACCESS 1 TAHUN"\n'
        '3. Masukkan kode promo: JADIJUARA\n'
        '4. Nikmati potongan harga instant!\n\n'
        '💯 GARANSI KEPUASAN:\n'
        'Tidak puas? Dapatkan uang kembali 100% dalam 7 hari pertama!\n\n'
        '🔊 KATA MEREKA YANG SUDAH BERGABUNG:\n'
        '"Investasi terbaik untuk pendidikan anak saya!" - Ibu Sari\n'
        '"Nilai rapor naik signifikan setelah 3 bulan!" - Budi, kelas 9\n\n'
        'JANGAN LEWATKAN! Kesempatan emas yang tidak akan terulang!\n'
        'DAFTAR SEKARANG SEBELUM KAMU MENYESAL!',
    promoCode: 'JADIJUARA',
    validUntil: DateTime(2025, 7, 29),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Harga normal Rp775.000/tahun',
      'Garansi refund 7 hari jika tidak puas',
      'Bonus merchandise selama persediaan ada',
      'Maksimal 2 paket per pengguna',
      'Kuota terbatas 5.000 pendaftar'
    ],
  ),
  Promotion(
    id: 'promo6',
    imagePath: 'assets/banners/th1.jpg',
    title: 'Paket Super Intensif SIMAK UI!',
    description:
        '🎓 JAMINAN LOLOS SIMAK UI 2025! 🎓\n\n'
        'PROGRAM PERSIAPAN PALING KOMPREHENSIF UNTUK MENAKLUKKAN UJIAN MASUK UNIVERSITAS INDONESIA!\n\n'
        '💎 PENAWARAN SPEKTAKULER TERBATAS:\n'
        '• Harga normal: Rp16.500.000\n'
        '• Harga spesial: Rp6.600.000\n'
        '• Hemat fantastis: Rp9.900.000 (60% OFF!)\n'
        '• Masa program: 6 bulan intensif\n'
        '• Sistem belajar: Hybrid (online & offline)\n\n'
        '🔍 MENGAPA PROGRAM KAMI BERBEDA:\n'
        '• Tingkat kelulusan siswa 87% pada SIMAK UI tahun lalu\n'
        '• Metode "UI Success Formula" yang telah terbukti selama 12 tahun\n'
        '• Dibimbing langsung oleh alumni UI dengan IPK >3.8\n'
        '• Kurikulum yang didesain khusus berdasarkan analisis soal 10 tahun terakhir\n'
        '• Sistem belajar adaptif yang menyesuaikan kebutuhan individual\n'
        '• Monitoring progress mingguan oleh academic advisor\n\n'
        '📚 PAKET LENGKAP YANG KAMU DAPATKAN:\n'
        '• 48 sesi bimbingan intensif (@ 120 menit)\n'
        '• 24 sesi pemantapan materi khusus SIMAK UI\n'
        '• 12 tryout eksklusif dengan sistem penilaian identik SIMAK UI\n'
        '• 8 sesi problem solving workshop untuk soal-soal killer\n'
        '• 4 sesi motivasi & strategi ujian oleh psikolog pendidikan\n'
        '• 6 modul eksklusif "SIMAK UI Killer Topics" (1.200+ halaman)\n'
        '• 3.000+ bank soal dengan pembahasan detail\n'
        '• Akses VIP ke platform digital pembelajaran 24/7\n'
        '• Konsultasi unlimited dengan mentor via grup WhatsApp\n\n'
        '👨‍🏫 TIM PENGAJAR SUPERIOR:\n'
        '• Dr. Bambang Wijaya, S.Si, M.Sc - Gold Medalist Olimpiade Matematika\n'
        '• Prof. Dian Kusuma, Ph.D - Peneliti Fisika di UI & MIT alumnus\n'
        '• Ir. Fajar Santoso, M.T - Penulis 8 buku soal SIMAK UI\n'
        '• Dr. Ratna Dewi, S.S, M.Hum - Pakar Bahasa & alumni terbaik UI\n'
        '• 12+ mentor alumni UI dari berbagai fakultas favorit\n\n'
        '🏆 TESTIMONI SUKSES:\n'
        '"Diterima di FK UI setelah mengikuti program ini!" - Aditya, batch 2023\n'
        '"Dari nilai simulasi awal 540 menjadi 780 di SIMAK UI asli" - Larasati, FE UI\n'
        '"Sistem belajarnya sangat efektif untuk menguasai materi dalam waktu singkat" - Reza, FT UI\n\n'
        '🔰 BONUS BERNILAI TINGGI:\n'
        '• UI Campus Tour & orientasi pre-university\n'
        '• E-book "UI Life Hack" senilai Rp1.200.000\n'
        '• Sesi khusus tips wawancara untuk fakultas tertentu\n'
        '• Akses gratis ke perpustakaan digital UI selama program\n'
        '• Mentoring personal oleh mahasiswa UI aktif (1 mentor untuk 5 siswa)\n\n'
        '⏱️ PERIODE PENDAFTARAN:\n'
        '• Batch terakhir untuk persiapan SIMAK UI 2025\n'
        '• Kuota: 35 siswa per kelas (total 3 kelas)\n'
        '• Status: HAMPIR PENUH! (80% terisi)\n'
        '• Batas akhir pendaftaran: 30 Agustus 2023\n\n'
        '💳 CARA MENDAFTAR:\n'
        '1. Klik tombol "DAFTAR PROGRAM"\n'
        '2. Isi form pendaftaran dan pilih jadwal interview\n'
        '3. Masukkan kode promo: MASUKUI\n'
        '4. Lakukan pembayaran (tersedia cicilan 0% hingga 12 bulan)\n\n'
        '✅ GARANSI PROGRAM:\n'
        'Jika tidak lolos SIMAK UI, dapatkan program intensif tahun depan GRATIS atau uang kembali 50%*\n'
        '(*syarat & ketentuan berlaku)\n\n'
        'INVESTASI TERBAIK UNTUK MASA DEPAN CEMERLANG DI UNIVERSITAS INDONESIA!\n'
        'JANGAN TUNDA LAGI - KUOTA HAMPIR PENUH!',
    promoCode: 'MASUKUI',
    validUntil: DateTime(2025, 8, 25),
    validFrom: DateTime(2025, 6, 15),
    termsConditions: [
      'Pembayaran dapat dicicil 12x tanpa bunga',
      'Garansi mengulang gratis jika tidak lolos',
      'Wajib mengikuti placement test',
      'Kuota terbatas 35 siswa/kelas',
      'Tidak termasuk biaya pendaftaran SIMAK UI'
    ],
  ),
];