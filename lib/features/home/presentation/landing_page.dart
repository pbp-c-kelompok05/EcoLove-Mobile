import 'package:flutter/material.dart';

import '../../auth/presentation/pages/login_page.dart';
import '../../events/presentation/pages/events_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _marketplaceKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();

  static const Color green = Color(0xFF287D35);
  static const Color cream = Color(0xFFFAF7F0);
  static const Color mint = Color(0xFFD1EFCF);
  static const Color ink = Color(0xFF1F3024);

  Future<void> _goTo(GlobalKey key) async {
    final target = key.currentContext;
    if (target == null) return;
    await Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0,
    );
  }

  void _openLogin() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
    );
  }

  void _openEvents() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const EventsPage()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              _buildHero(),
              _buildMarketplace(),
              _buildCommunity(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      key: _homeKey,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF102719), Color(0xFF347C38)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EcoLove',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 5),
              Image.asset(
                'assets/images/ecolove_logo.png',
                width: 31,
                height: 31,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navItem('Home', () => _goTo(_homeKey)),
              _navItem('Marketplace', () => _goTo(_marketplaceKey)),
              _navItem('Events', _openEvents),
              _navItem('Education', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halaman Education menyusul.')),
                );
              }),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _openLogin,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: 680,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/hero.jpg', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.20),
                  Colors.black.withOpacity(0.68),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(width: 25, height: 1, color: Colors.white),
                    const SizedBox(width: 9),
                    const Text(
                      'S U S T A I N A B L E  M A R K E T P L A C E',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Love Me\nAgain.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    height: 0.92,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.8,
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Give pre-loved items a second life and\nmake sustainable choices together with\nEcoLove.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 28),
                _heroButton(
                  label: 'EXPLORE MARKETPLACE',
                  filled: true,
                  onTap: () => _goTo(_marketplaceKey),
                ),
                const SizedBox(height: 8),
                _heroButton(
                  label: 'SELL AN ITEM',
                  filled: false,
                  onTap: _openLogin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroButton({
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 68,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? green : Colors.transparent,
          foregroundColor: Colors.white,
          side: BorderSide(
            color: filled ? green : Colors.white.withOpacity(0.75),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const Icon(Icons.north_east, size: 13),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketplace() {
    final products = <_Product>[
      const _Product('assets/images/product_jacket.jpg', 'Pre-loved denim jacket'),
      const _Product('assets/images/product_necklace.jpg', 'Upcycled necklace'),
      const _Product('assets/images/product_bag.jpg', 'Denim tote bag'),
      const _Product('assets/images/product_recycled_cube.jpg', 'Recycled craft'),
      const _Product('assets/images/product_woven_bag.jpg', 'Woven recycled bag'),
      const _Product('assets/images/product_upcycled_art.jpg', 'Upcycled decor'),
    ];

    return Container(
      key: _marketplaceKey,
      color: cream,
      padding: const EdgeInsets.only(top: 60, bottom: 62),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: 0,
            left: -5,
            child: _outlineWord('LOVE AGAIN', 76),
          ),
          Positioned(
            bottom: 0,
            left: -5,
            child: _outlineWord('LOVE AGAIN', 76),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'MARKETPLACE',
                    style: TextStyle(
                      color: Color(0xFF657568),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Find Something to\nLove Again',
                    style: TextStyle(
                      color: ink,
                      fontSize: 36,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Discover secondhand and sustainable\nproducts from the EcoLove community.',
                    style: TextStyle(
                      color: Color(0xFF68766B),
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 580,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    scrollDirection: Axis.horizontal,
                    itemCount: (products.length / 2).ceil(),
                    separatorBuilder: (_, __) => const SizedBox(width: 18),
                    itemBuilder: (context, column) {
                      final first = products[column * 2];
                      final second = products[column * 2 + 1];
                      return SizedBox(
                        width: 220,
                        child: Column(
                          children: [
                            _productCard(first),
                            const SizedBox(height: 18),
                            _productCard(second),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlineWord(String text, double size) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = const Color(0xFFD5E3D0),
      ),
    );
  }

  Widget _productCard(_Product product) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: _openLogin,
            child: Ink.image(
              image: AssetImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommunity() {
    final events = <String>[
      'assets/images/event_cleanup_1.jpg',
      'assets/images/event_cleanup_2.jpg',
      'assets/images/event_river.jpg',
      'assets/images/event_planting.jpg',
    ];

    return Container(
      key: _eventsKey,
      color: mint,
      padding: const EdgeInsets.fromLTRB(20, 78, 20, 65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'COMMUNITY',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join Sustainable\nActivities',
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              height: 1.35,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Find events that help you live more\nsustainably.',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 36),
          ...events.map(
            (path) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1.17,
                  child: Image.asset(path, fit: BoxFit.cover),
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
      color: green,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      child: const Text(
        '© 2026 EcoLove. Faculty of Computer Science,\nUniversity of Indonesia.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          height: 1.5,
        ),
      ),
    );
  }
}

class _Product {
  final String image;
  final String label;

  const _Product(this.image, this.label);
}
