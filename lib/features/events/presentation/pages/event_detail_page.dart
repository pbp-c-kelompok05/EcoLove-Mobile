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
  static const Color _mint = Color(0xFFD1EFCF);
  static const Color _ink = Color(0xFF1F3024);

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

  String _formatDateRange(DateTime start, DateTime end) {
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
    final date = '${start.day} ${months[start.month - 1]} ${start.year}';
    String hhmm(DateTime d) =>
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    return '$date • ${hhmm(start)}–${hhmm(end)} WIB';
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
              ? 'Berhasil mendaftar event!'
              : 'Pendaftaran event dibatalkan.',
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
      appBar: AppBar(
        backgroundColor: _darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Event',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_event.imageAsset != null)
              AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.asset(_event.imageAsset!, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _badge(_event.categoryLabel, _mint, _ink),
                      _badge(
                        _event.statusLabel,
                        _event.statusLabel == 'Mendatang'
                            ? _green
                            : Colors.grey.shade700,
                        Colors.white,
                      ),
                      if (_event.isOnline)
                        _badge('Online', Colors.teal.shade50, Colors.teal.shade900),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _infoRow(
                    Icons.calendar_today_outlined,
                    _formatDateRange(_event.startsAt, _event.endsAt),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    _event.isOnline
                        ? Icons.videocam_outlined
                        : Icons.location_on_outlined,
                    _event.location,
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    Icons.people_outline,
                    '${_event.registrationCount} peserta terdaftar',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _toggleParticipation,
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            _event.isRegistered ? Colors.red.shade700 : _green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        _event.isRegistered
                            ? Icons.cancel_outlined
                            : Icons.event_available_outlined,
                      ),
                      label: Text(
                        _event.isRegistered
                            ? 'Batalkan Pendaftaran'
                            : (_event.registrationOpen
                                ? 'Daftar Event'
                                : 'Pendaftaran Ditutup'),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tentang Kegiatan',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _event.description,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.6,
                      color: Color(0xFF425246),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Diskusi & Komentar (${_event.comments.length})',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Tulis komentar tentang event ini...',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: _addComment,
                        style: IconButton.styleFrom(backgroundColor: _green),
                        icon: const Icon(Icons.send_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_event.comments.isEmpty)
                    const Text(
                      'Belum ada komentar. Jadilah yang pertama berdiskusi!',
                      style: TextStyle(color: Color(0xFF68766B)),
                    )
                  else
                    ..._event.comments.map(
                      (comment) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE1E8DE)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _ink,
                                fontSize: 13.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              comment.body,
                              style: const TextStyle(
                                color: Color(0xFF425246),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _green),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: _ink,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
