import 'package:flutter/material.dart';

import '../../models/event_model.dart';
import 'event_detail_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  static const Color _green = Color(0xFF287D35);
  static const Color _darkGreen = Color(0xFF102719);
  static const Color _cream = Color(0xFFFAF7F0);
  static const Color _ink = Color(0xFF1F3024);

  String _searchQuery = '';
  String _selectedCategory = 'all';

  static const List<Map<String, String>> _categories = [
    {'value': 'all', 'label': 'Semua'},
    {'value': 'reuse', 'label': 'Reuse & Repair'},
    {'value': 'waste', 'label': 'Minim Sampah'},
    {'value': 'lifestyle', 'label': 'Gaya Hidup'},
  ];

  List<EventItem> get _filteredEvents {
    return sampleEvents.where((event) {
      final matchesCategory =
          _selectedCategory == 'all' || event.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.description.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  String _formatDate(DateTime dt) {
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
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'EcoLove Events',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_darkGreen, Color(0xFF347C38)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Temukan Kegiatan Berkelanjutan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ikuti workshop, aksi bersih lingkungan, dan bazar tukar barang.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Cari event atau lokasi...',
                    prefixIcon: const Icon(Icons.search, color: _green),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final item = _categories[index];
                final isSelected = _selectedCategory == item['value'];
                return ChoiceChip(
                  label: Text(item['label']!),
                  selected: isSelected,
                  selectedColor: _green,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : _ink,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    setState(() => _selectedCategory = item['value']!);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: events.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada event yang sesuai pencarian.',
                      style: TextStyle(color: Color(0xFF68766B)),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: events.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return _EventCard(
                        event: event,
                        dateLabel: _formatDate(event.startsAt),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => EventDetailPage(event: event),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItem event;
  final String dateLabel;
  final VoidCallback onTap;

  const _EventCard({
    required this.event,
    required this.dateLabel,
    required this.onTap,
  });

  static const Color _green = Color(0xFF287D35);
  static const Color _mint = Color(0xFFD1EFCF);
  static const Color _ink = Color(0xFF1F3024);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.imageAsset != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(event.imageAsset!, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _mint,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          event.categoryLabel,
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: event.statusLabel == 'Mendatang'
                              ? _green
                              : Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          event.statusLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF5D6C60),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 15,
                        color: _green,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateLabel,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: _ink,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Icon(
                        event.isOnline
                            ? Icons.videocam_outlined
                            : Icons.location_on_outlined,
                        size: 15,
                        color: _green,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: _ink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
