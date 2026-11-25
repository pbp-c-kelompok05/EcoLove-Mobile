import 'package:flutter/material.dart';

class ItemFormPage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const ItemFormPage({super.key, this.initialData});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _price;
  late String _description;
  String _selectedCategory = 'Fashion';

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
    _name = widget.initialData?['name'] ?? '';
    _price = widget.initialData?['price']?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
    _description = widget.initialData?['description'] ?? '';
    if (widget.initialData?['category'] != null &&
        _categories.contains(widget.initialData!['category'])) {
      _selectedCategory = widget.initialData!['category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialData != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang Baru'),
        backgroundColor: Colors.green[700],
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
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Harga wajib diisi' : null,
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
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Perubahan "$_name" disimpan!'
                              : 'Barang "$_name" berhasil ditambahkan!',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}