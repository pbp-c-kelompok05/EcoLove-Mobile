import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../config/api_config.dart';
import '../models/item_model.dart';
import 'my_marketplace_page.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  Future<List<Item>> fetchPublicItems(CookieRequest request) async {
    final response = await request.get('${ApiConfig.baseUrl}/marketplace/api/drf/items/');

    List<Item> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(Item.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: const Color(0xFF287D35),
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyMarketplacePage(),
                ),
              );
              setState(() {}); // Refresh katalog setelah kembali dari My Marketplace
            },
            icon: const Icon(Icons.storefront, color: Colors.white),
            label: const Text(
              'My Marketplace',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchPublicItems(request),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat data marketplace:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada produk yang tersedia di Marketplace.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: item.image != null && item.image!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.image!.startsWith('http')
                                ? item.image!
                                : '${ApiConfig.baseUrl}${item.image!}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const CircleAvatar(
                              backgroundColor: Color(0xFFD1EFCF),
                              child: Icon(Icons.eco, color: Color(0xFF287D35)),
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          backgroundColor: Color(0xFFD1EFCF),
                          child: Icon(Icons.eco, color: Color(0xFF287D35)),
                        ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${item.category} • Rp ${item.price}\nPenjual: ${item.seller}',
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
                          content: Text(
                            'Detail produk "${item.name}" (integrasi payment menyusul)',
                          ),
                        ),
                      );
                    },
                    child: const Text('Beli'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}