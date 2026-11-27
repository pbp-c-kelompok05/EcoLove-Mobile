import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../config/api_config.dart';
import '../models/item_model.dart';
import 'item_form_page.dart';

class MyMarketplacePage extends StatefulWidget {
  const MyMarketplacePage({super.key});

  @override
  State<MyMarketplacePage> createState() => _MyMarketplacePageState();
}

class _MyMarketplacePageState extends State<MyMarketplacePage> {
  Future<List<Item>> fetchMyItems(CookieRequest request) async {
    final response = await request.get(
      '${ApiConfig.baseUrl}/marketplace/api/drf/my-items/',
    );

    List<Item> listItem = [];
    for (var d in response) {
      if (d != null) {
        listItem.add(Item.fromJson(d));
      }
    }
    return listItem;
  }

  Future<void> deleteItem(
    CookieRequest request,
    String itemId,
    String itemName,
  ) async {
    try {
      final response = await request.post(
        '${ApiConfig.baseUrl}/marketplace/delete/ajax/$itemId/',
        {},
      );

      if (!mounted) return;

      if (response['status'] == 'success' || response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"$itemName" berhasil dihapus!')),
        );
        setState(() {}); // Refresh list setelah hapus
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Gagal menghapus barang.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Marketplace'),
        backgroundColor: const Color(0xFF287D35),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchMyItems(request),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat barang kamu:\n${snapshot.error}\n(Pastikan sudah login)',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Kamu belum menjual barang apa pun.',
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
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.eco,
                    color: Color(0xFF287D35),
                    size: 36,
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${item.category} • Rp ${item.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemFormPage(initialItem: item),
                            ),
                          );
                          if (updated == true) setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            deleteItem(request, item.id, item.name),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemFormPage()),
          );
          if (created == true) setState(() {});
        },
        backgroundColor: const Color(0xFF287D35),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}
