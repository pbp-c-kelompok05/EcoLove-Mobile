import 'package:flutter/material.dart';

import '../../models/education_model.dart';
import 'education_detail_page.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
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

  List<EducationArticle> get _filteredArticles {
    return sampleEducationArticles.where((article) {
      final matchesCategory =
          _selectedCategory == 'all' || article.category == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          article.title.toLowerCase().contains(query) ||
          article.summary.toLowerCase().contains(query) ||
          article.body.toLowerCase().contains(query);
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
    final articles = _filteredArticles;

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'EcoLove Education',
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
                  'Belajar Gaya Hidup Berkelanjutan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Artikel seputar konsumsi sadar, perawatan barang, dan minim sampah.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Cari artikel edukasi...',
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
            child: articles.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada artikel yang sesuai pencarian.',
                      style: TextStyle(color: Color(0xFF68766B)),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: articles.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return _EducationCard(
                        article: article,
                        dateLabel: _formatDate(article.createdAt),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  EducationDetailPage(article: article),
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

class _EducationCard extends StatelessWidget {
  final EducationArticle article;
  final String dateLabel;
  final VoidCallback onTap;

  const _EducationCard({
    required this.article,
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
            if (article.imageAsset != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(article.imageAsset!, fit: BoxFit.cover),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      article.categoryLabel,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.summary,
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
                        Icons.person_outline,
                        size: 15,
                        color: _green,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        article.authorName,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: _ink,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: _green,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        dateLabel,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: _ink,
                          fontWeight: FontWeight.w500,
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
