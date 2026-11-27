class EducationArticle {
  final String id;
  final String title;
  final String category;
  final String categoryLabel;
  final String summary;
  final String body;
  final String? imageAsset;
  final String? imageUrl;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EducationArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.categoryLabel,
    required this.summary,
    required this.body,
    this.imageAsset,
    this.imageUrl,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EducationArticle.fromJson(Map<String, dynamic> json) {
    final created =
        DateTime.tryParse(json['created_at']?.toString() ?? '') ??
        DateTime.now();
    return EducationArticle(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'reuse',
      categoryLabel: json['category_label']?.toString() ?? 'Reuse & Repair',
      summary: json['summary']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      imageUrl: json['image']?.toString(),
      authorName: json['author_name']?.toString() ?? 'EcoLove Editorial',
      createdAt: created,
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ?? created,
    );
  }
}

final List<EducationArticle> sampleEducationArticles = [
  EducationArticle(
    id: 'edu-001',
    title: 'Cara Merawat Pakaian Preloved Agar Awet Bertahun-tahun',
    category: 'reuse',
    categoryLabel: 'Reuse & Repair',
    summary:
        'Tips mencuci, mengeringkan, dan memperbaiki pakaian bekas berkualitas agar tetap nyaman dipakai lebih lama.',
    body:
        'Memperpanjang masa pakai pakaian adalah salah satu cara paling efektif untuk mengurangi limbah tekstil.\n\n'
        '1. Cuci dengan air dingin dan deterjen lembut agar serat kain tidak cepat rusak.\n'
        '2. Hindari mesin pengering bersuhu tinggi; jemur di tempat teduh dengan sirkulasi udara baik.\n'
        '3. Segera jahit kancing yang longgar atau robekan kecil sebelum melebar.\n\n'
        'Dengan perawatan sederhana, pakaian preloved pilihanmu bisa terus menemani aktivitas harian dengan konsep Love Me Again.',
    imageAsset: 'assets/images/product_jacket.jpg',
    authorName: 'ecolove_admin',
    createdAt: DateTime(2026, 11, 20),
    updatedAt: DateTime(2026, 11, 20),
  ),
  EducationArticle(
    id: 'edu-002',
    title: 'Panduan Pemula Memilah Sampah Organik dan Anorganik di Rumah',
    category: 'waste',
    categoryLabel: 'Minim Sampah',
    summary:
        'Langkah praktis menyiapkan dua wadah pilah sederhana dan memulai kompos rumahan tanpa bau.',
    body:
        'Memilah sampah dari sumbernya memudahkan proses daur ulang dan mengurangi timbulan sampah ke TPA.\n\n'
        '• Sampah Organik: sisa sayur, kulit buah, ampas kopi, dan daun kering dapat diolah menjadi kompos.\n'
        '• Sampah Anorganik Terpilah: bersihkan dan keringkan botol plastik, kardus, serta kaleng sebelum disetor ke bank sampah.\n'
        '• Residu: minimalkan penggunaan kemasan sekali pakai sejak saat berbelanja.\n\n'
        'Mulai dari satu kebiasaan kecil setiap hari untuk perubahan lingkungan yang nyata.',
    imageAsset: 'assets/images/event_planting.jpg',
    authorName: 'ecolove_admin',
    createdAt: DateTime(2026, 11, 18),
    updatedAt: DateTime(2026, 11, 18),
  ),
  EducationArticle(
    id: 'edu-003',
    title: 'Konsumsi Sadar: 5 Pertanyaan Sebelum Membeli Barang Baru',
    category: 'lifestyle',
    categoryLabel: 'Gaya Hidup',
    summary:
        'Kerangka berpikir sederhana untuk menghindari pembelian impulsif dan memilih alternatif preloved atau lokal.',
    body:
        'Konsumsi sadar bukan berarti berhenti membeli, melainkan memilih barang yang benar-benar dibutuhkan dan tahan lama.\n\n'
        'Sebelum checkout, tanyakan pada diri sendiri:\n'
        '1. Apakah saya sudah punya barang serupa di rumah?\n'
        '2. Apakah barang ini bisa dibeli dalam kondisi preloved?\n'
        '3. Seberapa sering saya akan memakainya dalam 6 bulan ke depan?\n'
        '4. Apakah bahannya mudah diperbaiki jika rusak?\n'
        '5. Bagaimana dampaknya setelah tidak terpakai lagi?\n\n'
        'Pilihan kecil saat berbelanja membantu membangun ekonomi sirkular yang lebih sehat.',
    imageAsset: 'assets/images/product_woven_bag.jpg',
    authorName: 'ecolove_admin',
    createdAt: DateTime(2026, 11, 15),
    updatedAt: DateTime(2026, 11, 15),
  ),
];
