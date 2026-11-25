import 'package:flutter/material.dart';
import 'my_marketplace_page.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data katalog umum sementara (Checkpoint 1)
    final List publicItems = [
      {
        'name': 'Jaket Denim Preloved',
        'price': 'Rp 150.000',
        'category': 'Fashion',
        'seller': 'karenlim',
      },
      {
        'name': 'Tumbler Stainless Reusable',
        'price': 'Rp 75.000',
        'category': 'Zero Waste',
        'seller': 'karenlim',
      },
      {
        'name': 'Tas Rajut Daur Ulang',
        'price': 'Rp 120.000',
        'category': 'Fashion',
        'seller': 'maurilla',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: const Color(0xFF287D35),
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyMarketplacePage(),
                ),
              );
            },
            icon: const Icon(Icons.storefront, color: Colors.white),
            label: const Text(
              'My Marketplace',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: publicItems.length,
        itemBuilder: (context, index) {
          final item = publicItems[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFD1EFCF),
                child: Icon(Icons.eco, color: Color(0xFF287D35)),
              ),
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${item['category']} • ${item['price']}\nPenjual: ${item['seller']}',
              ),
              isThreeLine: true,
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF287D35),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Detail produk "${item['name']}" (integrasi payment menyusul)'),
                    ),
                  );
                },
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}