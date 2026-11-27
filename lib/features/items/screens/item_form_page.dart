import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../config/api_config.dart';
import '../models/item_model.dart';

class ItemFormPage extends StatefulWidget {
  final Item? initialItem;

  const ItemFormPage({super.key, this.initialItem});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _price;
  late String _description;
  late String _imageUrl;
  String _selectedCategory = 'Fashion';
  bool _isLoading = false;

  final List<String> _categories = [
    'Fashion',
    'Electronics',
    'Furniture',
    'Books',
    'Zero Waste',
  ];

  @override
  void initState() {
    super.initState();
    _name = widget.initialItem?.name ?? '';
    _price = widget.initialItem?.price.toString() ?? '';
    _description = widget.initialItem?.description ?? '';
    _imageUrl = widget.initialItem?.image ?? '';
    if (widget.initialItem?.category != null &&
        _categories.contains(widget.initialItem!.category)) {
      _selectedCategory = widget.initialItem!.category;
    }
  }

  Future<void> _submitForm(CookieRequest request) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final isEdit = widget.initialItem != null;

    final url = isEdit
    ? '${ApiConfig.baseUrl}/marketplace/edit/${widget.initialItem!.id}/'
    : '${ApiConfig.baseUrl}/marketplace/add/';

    try {
      final response = await request.postJson(
        url,
        jsonEncode({
          'name': _name,
          'price': int.tryParse(_price) ?? 0,
          'category': _selectedCategory,
          'description': _description,
          'image': _imageUrl,
        }),
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response['status'] == 'success' || response['id'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? 'Perubahan "$_name" berhasil disimpan!'
                  : 'Barang "$_name" berhasil ditambahkan!',
            ),
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Gagal menyimpan barang.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final isEdit = widget.initialItem != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang Baru'),
        backgroundColor: const Color(0xFF287D35),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _name = value,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Nama barang wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _price = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Harga wajib diisi';
                  if (int.tryParse(value) == null) return 'Harga harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _imageUrl,
                decoration: const InputDecoration(
                  labelText: 'URL Gambar (Opsional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _imageUrl = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Barang',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Deskripsi wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF287D35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isLoading ? null : () => _submitForm(request),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(isEdit ? 'Simpan Perubahan' : 'Simpan Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}