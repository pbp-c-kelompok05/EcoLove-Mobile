import 'package:flutter/material.dart';

import '../../../auth/presentation/pages/login_page.dart';
import '../../models/education_model.dart';
import '../widgets/education_banner.dart';
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
  static const Color _muted = Color(0xFF68766B);
  static const Color _border = Color(0xFFE5E9DF);
  static const Color _outlineBorder = Color(0xFF99BBA0);

  final TextEditingController _searchController = TextEditingController();
  String _appliedQuery = '';
  String _selectedCategory = 'all';

  static const List<Map<String, String>> _categories = [
    {'value': 'all', 'label': 'Semua'},
    {'value': 'reuse', 'label': 'Reuse & Repair'},
    {'value': 'waste', 'label': 'Minim Sampah'},
    {'value': 'lifestyle', 'label': 'Gaya Hidup'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _appliedQuery.isNotEmpty || _selectedCategory != 'all';

  List<EducationArticle> get _filteredArticles {
    return sampleEducationArticles.where((article) {
      final matchesCategory =
          _selectedCategory == 'all' || article.category == _selectedCategory;
      final query = _appliedQuery.trim().toLowerCase();
      final matchesQuery =
          query.isEmpty ||
          article.title.toLowerCase().contains(query) ||
          article.summary.toLowerCase().contains(query) ||
          article.body.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _applySearch() {
    setState(() => _appliedQuery = _searchController.text.trim());
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _appliedQuery = '';
      _selectedCategory = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filteredArticles;

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
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Education',
                      style: TextStyle(
                        color: _green,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Belajar merawat. Belajar mengurangi.',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.7,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Panduan sederhana agar barang bertahan lebih lama dan kebiasaan baik tumbuh setiap hari.',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 14.5,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const EducationBannerIllustration(),
                    const SizedBox(height: 20),
                    const Text(
                      'Cari konten',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: (_) => _applySearch(),
                            onChanged: (value) =>
                                setState(() => _appliedQuery = value.trim()),
                            style: const TextStyle(color: _ink, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Cari panduan yang ingin kamu pelajari…',
                              hintStyle: const TextStyle(
                                color: _muted,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
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
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: _applySearch,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _green,
                            side: const BorderSide(color: _outlineBorder),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Cari',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Kategori',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _border),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: _green,
                          ),
                          style: const TextStyle(
                            color: _green,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          items: _categories
                              .map(
                                (cat) => DropdownMenuItem<String>(
                                  value: cat['value'],
                                  child: Text(cat['label']!),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedCategory = value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${articles.length} artikel ${_hasActiveFilters ? 'ditemukan' : 'untuk kamu'}',
                      style: const TextStyle(color: _muted, fontSize: 13.5),
                    ),
                    const SizedBox(height: 12),
                    if (articles.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: _border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Belum menemukan yang kamu cari?',
                              style: TextStyle(
                                color: _ink,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Tidak ada konten yang cocok dengan pencarian atau filter ini.',
                              style: TextStyle(color: _muted, fontSize: 14),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton(
                              onPressed: _resetFilters,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _green,
                                side: const BorderSide(color: _outlineBorder),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text('Reset pencarian dan filter'),
                            ),
                          ],
                        ),
                      )
                    else
                      ...articles.map(
                        (article) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _EducationWebCard(
                            article: article,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      EducationDetailPage(article: article),
                                ),
                              );
                            },
                          ),
                        ),
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
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const LoginPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: _green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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

class _EducationWebCard extends StatelessWidget {
  final EducationArticle article;
  final VoidCallback onTap;

  const _EducationWebCard({required this.article, required this.onTap});

  static const Color _green = Color(0xFF287D35);
  static const Color _ink = Color(0xFF1F3024);
  static const Color _muted = Color(0xFF68766B);
  static const Color _border = Color(0xFFE5E9DF);
  static const Color _outlineBorder = Color(0xFF99BBA0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.imageAsset != null)
            GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AspectRatio(
                  aspectRatio: 2.0,
                  child: Image.asset(article.imageAsset!, fit: BoxFit.cover),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 4, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.categoryLabel,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    article.title,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.summary,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _green,
                      side: const BorderSide(color: _outlineBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Baca artikel',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text('→', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
