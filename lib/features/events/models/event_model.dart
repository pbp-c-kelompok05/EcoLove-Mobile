class EventCommentItem {
  final String id;
  final String eventId;
  final String username;
  final String body;
  final String? image;
  final bool canDelete;
  final DateTime createdAt;

  const EventCommentItem({
    required this.id,
    required this.eventId,
    required this.username,
    required this.body,
    this.image,
    this.canDelete = false,
    required this.createdAt,
  });

  factory EventCommentItem.fromJson(Map<String, dynamic> json) {
    return EventCommentItem(
      id: json['id']?.toString() ?? '',
      eventId: json['event']?.toString() ?? '',
      username: json['username']?.toString() ?? 'EcoLove User',
      body: json['body']?.toString() ?? '',
      image: json['image']?.toString(),
      canDelete: json['can_delete'] == true,
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class EventItem {
  final String id;
  final String title;
  final String category;
  final String categoryLabel;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final String location;
  final bool isOnline;
  final String? organizerContact;
  final String? meetingLink;
  final String? imageAsset;
  final String? imageUrl;
  final String creatorName;
  final String statusLabel;
  final bool registrationOpen;
  final int registrationCount;
  final bool isRegistered;
  final List<EventCommentItem> comments;

  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.categoryLabel,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.location,
    required this.isOnline,
    this.organizerContact,
    this.meetingLink,
    this.imageAsset,
    this.imageUrl,
    required this.creatorName,
    required this.statusLabel,
    required this.registrationOpen,
    required this.registrationCount,
    required this.isRegistered,
    this.comments = const [],
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'reuse',
      categoryLabel: json['category_label']?.toString() ?? 'Reuse & Repair',
      description: json['description']?.toString() ?? '',
      startsAt:
          DateTime.tryParse(json['starts_at']?.toString() ?? '') ??
          DateTime.now(),
      endsAt:
          DateTime.tryParse(json['ends_at']?.toString() ?? '') ??
          DateTime.now(),
      location: json['location']?.toString() ?? '',
      isOnline: json['is_online'] == true,
      organizerContact: json['organizer_contact']?.toString(),
      meetingLink: json['meeting_link']?.toString(),
      imageUrl: json['image']?.toString(),
      creatorName: json['creator_name']?.toString() ?? 'EcoLove Admin',
      statusLabel: json['status_label']?.toString() ?? 'Mendatang',
      registrationOpen: json['registration_open'] == true,
      registrationCount: (json['registration_count'] as num?)?.toInt() ?? 0,
      isRegistered: json['is_registered'] == true,
    );
  }

  EventItem copyWith({
    int? registrationCount,
    bool? isRegistered,
    List<EventCommentItem>? comments,
  }) {
    return EventItem(
      id: id,
      title: title,
      category: category,
      categoryLabel: categoryLabel,
      description: description,
      startsAt: startsAt,
      endsAt: endsAt,
      location: location,
      isOnline: isOnline,
      organizerContact: organizerContact,
      meetingLink: meetingLink,
      imageAsset: imageAsset,
      imageUrl: imageUrl,
      creatorName: creatorName,
      statusLabel: statusLabel,
      registrationOpen: registrationOpen,
      registrationCount: registrationCount ?? this.registrationCount,
      isRegistered: isRegistered ?? this.isRegistered,
      comments: comments ?? this.comments,
    );
  }
}

final List<EventItem> sampleEvents = [
  EventItem(
    id: 'evt-001',
    title: 'Workshop Repair & Upcycle Pakaian Preloved',
    category: 'reuse',
    categoryLabel: 'Reuse & Repair',
    description:
        'Belajar teknik jahit dasar, tambal kain kreatif (sashiko), dan upcycle pakaian bekas agar kembali layak pakai bersama komunitas EcoLove.',
    startsAt: DateTime(2026, 12, 5, 9, 30),
    endsAt: DateTime(2026, 12, 5, 12, 30),
    location: 'Taman Lingkar Kampus UI, Depok',
    isOnline: false,
    organizerContact: 'community@ecolove.id',
    imageAsset: 'assets/images/event_cleanup_1.jpg',
    creatorName: 'ecolove_admin',
    statusLabel: 'Mendatang',
    registrationOpen: true,
    registrationCount: 24,
    isRegistered: false,
    comments: [
      EventCommentItem(
        id: 'cmt-001',
        eventId: 'evt-001',
        username: 'qanita',
        body: 'Boleh bawa celana jeans bekas sendiri untuk ditambal di lokasi?',
        createdAt: DateTime(2026, 11, 24, 14, 20),
      ),
    ],
  ),
  EventItem(
    id: 'evt-002',
    title: 'Aksi Bersih Sungai Ciliwung & Pilah Sampah',
    category: 'waste',
    categoryLabel: 'Minim Sampah',
    description:
        'Bergabung dalam aksi bersih sungai bersama relawan lokal. Sarung tangan, karung pilah, dan sesi edukasi daur ulang disediakan di lokasi.',
    startsAt: DateTime(2026, 12, 12, 7, 0),
    endsAt: DateTime(2026, 12, 12, 11, 0),
    location: 'Bantaran Sungai Ciliwung, Lenteng Agung',
    isOnline: false,
    organizerContact: 'ciliwung@ecolove.id',
    imageAsset: 'assets/images/event_river.jpg',
    creatorName: 'ecolove_admin',
    statusLabel: 'Mendatang',
    registrationOpen: true,
    registrationCount: 41,
    isRegistered: true,
    comments: [
      EventCommentItem(
        id: 'cmt-002',
        eventId: 'evt-002',
        username: 'karen',
        body: 'Sudah daftar! Jangan lupa bawa tumbler masing-masing ya.',
        createdAt: DateTime(2026, 11, 25, 9, 10),
      ),
    ],
  ),
  EventItem(
    id: 'evt-003',
    title: 'Webinar Gaya Hidup Minim Sampah di Kosan',
    category: 'lifestyle',
    categoryLabel: 'Gaya Hidup',
    description:
        'Diskusi santai tentang langkah praktis mengurangi sampah plastik harian bagi mahasiswa dan pekerja muda dengan budget terjangkau.',
    startsAt: DateTime(2026, 11, 25, 15, 0),
    endsAt: DateTime(2026, 11, 25, 17, 30),
    location: 'Zoom Meeting (Online)',
    isOnline: true,
    organizerContact: 'webinar@ecolove.id',
    meetingLink: 'https://ecolove.id/meet/low-waste-kos',
    imageAsset: 'assets/images/event_planting.jpg',
    creatorName: 'ecolove_admin',
    statusLabel: 'Berlangsung',
    registrationOpen: false,
    registrationCount: 68,
    isRegistered: false,
  ),
  EventItem(
    id: 'evt-004',
    title: 'Bazar Tukar Barang & Donasi Buku Bekas',
    category: 'reuse',
    categoryLabel: 'Reuse & Repair',
    description:
        'Tukar buku, pakaian layak pakai, dan wadah pakai ulang tanpa transaksi uang. Sisa donasi disalurkan ke taman baca masyarakat.',
    startsAt: DateTime(2026, 11, 10, 10, 0),
    endsAt: DateTime(2026, 11, 10, 16, 0),
    location: 'Balai Sidang UI, Depok',
    isOnline: false,
    imageAsset: 'assets/images/event_cleanup_2.jpg',
    creatorName: 'ecolove_admin',
    statusLabel: 'Selesai',
    registrationOpen: false,
    registrationCount: 52,
    isRegistered: false,
  ),
];
