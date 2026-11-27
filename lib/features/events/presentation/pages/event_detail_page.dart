import 'package:flutter/material.dart';

import '../../models/event_model.dart';

class EventDetailPage extends StatefulWidget {
  final EventItem event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  static const Color _green = Color(0xFF287D35);
  static const Color _darkGreen = Color(0xFF102719);
  static const Color _cream = Color(0xFFFAF7F0);
  static const Color _sagePanel = Color(0xFFEFF4E8);
  static const Color _ink = Color(0xFF1F3024);
  static const Color _muted = Color(0xFF68766B);
  static const Color _border = Color(0xFFE5E9DF);
  static const Color _outlineBorder = Color(0xFF99BBA0);
  static const Color _statusFg = Color(0xFF548147);

  late EventItem _event;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _formatDateTimeWib(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$day ${months[dt.month - 1]} ${dt.year} $hh:$mm WIB';
  }

  void _toggleParticipation() {
    if (!_event.registrationOpen && !_event.isRegistered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pendaftaran ditutup karena event sudah dimulai atau selesai.',
          ),
        ),
      );
      return;
    }

    setState(() {
      final nextRegistered = !_event.isRegistered;
      final nextCount = nextRegistered
          ? _event.registrationCount + 1
          : (_event.registrationCount > 0 ? _event.registrationCount - 1 : 0);
      _event = _event.copyWith(
        isRegistered: nextRegistered,
        registrationCount: nextCount,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _event.isRegistered
              ? 'Pendaftaran berhasil. Sampai bertemu di kegiatan!'
              : 'Keikutsertaan dibatalkan.',
        ),
      ),
    );
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final newComment = EventCommentItem(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      eventId: _event.id,
      username: 'Kamu',
      body: text,
      canDelete: true,
      createdAt: DateTime.now(),
    );

    setState(() {
      _event = _event.copyWith(comments: [..._event.comments, newComment]);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Events / ${_event.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF8C9486),
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_event.imageAsset != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: AspectRatio(
                          aspectRatio: 2.1,
                          child: Image.asset(
                            _event.imageAsset!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          _event.categoryLabel,
                          style: const TextStyle(
                            color: _green,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _sagePanel,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _event.statusLabel,
                            style: const TextStyle(
                              color: _statusFg,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _event.title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _event.description,
                      style: const TextStyle(
                        color: Color(0xFF65705D),
                        fontSize: 14.5,
                        height: 1.65,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Sebelum ikut kegiatan',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 17.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _bullet('Catat jadwal dan lokasi kegiatan.'),
                    _bullet('Daftarkan keikutsertaan sebelum event dimulai.'),
                    _bullet('Hubungi penyelenggara untuk kebutuhan khusus.'),
                    const SizedBox(height: 22),
                    _buildSchedulePanel(),
                    const SizedBox(height: 16),
                    _buildRegistrationInfoPanel(),
                    const SizedBox(height: 24),
                    Text(
                      'Komentar komunitas (${_event.comments.length})',
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 17.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_event.comments.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Belum ada komentar. Mulai diskusinya!',
                          style: TextStyle(color: _muted, fontSize: 14),
                        ),
                      )
                    else
                      ..._event.comments.map(
                        (comment) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: _border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.username,
                                style: const TextStyle(
                                  color: _ink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                comment.body,
                                style: const TextStyle(
                                  color: Color(0xFF65705D),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tulis komentar',
                            style: TextStyle(
                              color: Color(0xFF52604E),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _commentController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Bagikan pertanyaan atau pengalamanmu…',
                              hintStyle: const TextStyle(
                                color: Color(0xFFA0A69A),
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: _border),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: _green),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _addComment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                            ),
                            child: const Text('Kirim komentar'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _green,
                        side: const BorderSide(color: _outlineBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                      ),
                      child: const Text('← Kembali ke events'),
                    ),
                  ],
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchedulePanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEDF0E6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catat jadwalnya',
            style: TextStyle(
              color: _ink,
              fontSize: 17.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _metaPair('Mulai', _formatDateTimeWib(_event.startsAt)),
          _metaPair('Selesai', _formatDateTimeWib(_event.endsAt)),
          _metaPair(
            _event.isOnline ? 'Platform online' : 'Lokasi',
            _event.location,
          ),
          _metaPair('Peserta terdaftar', '${_event.registrationCount} orang'),
          const SizedBox(height: 14),
          if (_event.isRegistered) ...[
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '✓ Kamu sudah terdaftar.',
                style: TextStyle(
                  color: _green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _toggleParticipation,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _green,
                  side: const BorderSide(color: _outlineBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Batalkan keikutsertaan'),
              ),
            ),
          ] else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _event.registrationOpen ? _toggleParticipation : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: _green.withValues(alpha: 0.45),
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  _event.registrationOpen
                      ? 'Daftar kegiatan'
                      : 'Pendaftaran ditutup',
                ),
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            'Pendaftaran ditutup saat event dimulai. Semua waktu dalam WIB (UTC+7).',
            style: TextStyle(color: _muted, fontSize: 12.5, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationInfoPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _sagePanel,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi pendaftaran',
            style: TextStyle(
              color: _ink,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          _metaPair(
            'Kontak penyelenggara',
            _event.organizerContact ?? 'Belum tersedia',
          ),
          _metaPair(
            'Link pertemuan',
            _event.meetingLink ?? 'Belum tersedia',
          ),
        ],
      ),
    );
  }

  Widget _metaPair(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF89917F), fontSize: 12.5),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF52604E), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•  ',
            style: TextStyle(color: Color(0xFF73A162), fontSize: 15),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF7C8575),
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_darkGreen, Color(0xFF347C38)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            tooltip: 'Kembali',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
          ),
          const SizedBox(width: 4),
          const Text(
            'EcoLove',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(width: 5),
          Image.asset(
            'assets/images/ecolove_logo.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: _green,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: const Text(
        '© 2026 EcoLove. Faculty of Computer Science,\nUniversity of Indonesia.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 11, height: 1.5),
      ),
    );
  }
}
