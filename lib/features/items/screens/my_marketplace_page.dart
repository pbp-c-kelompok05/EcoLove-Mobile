import 'package:flutter/material.dart';

import 'item_form_page.dart';

class MyMarketplacePage extends StatelessWidget {
  const MyMarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data statis sementara untuk Checkpoint 1
    final List dummyItems = [
      {
        'name': 'Jaket Denim Preloved',
        'price': 'Rp 150.000',
        'category': 'Fashion',
        'status': 'Available',
      },
      {
        'name': 'Tumbler Stainless Reusable',
        'price': 'Rp 75.000',
        'category': 'Zero Waste',
        'status': 'Available',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Marketplace'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyItems.length,
        itemBuilder: (context, index) {
          final item = dummyItems[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              leading: const Icon(Icons.eco, color: Colors.green, size: 36),
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${item['category']} • ${item['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemFormPage(initialData: item),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hapus ${item['name']}')),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemFormPage()),
          );
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}
