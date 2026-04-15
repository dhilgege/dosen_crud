import 'package:flutter/material.dart';

import '../../domain/entities/dosen.dart';
import '../utils/input_validators.dart';

/// Dialog for adding or editing dosen data
class DosenFormDialog extends StatefulWidget {
  final Dosen? dosen; // null for add, not null for edit

  const DosenFormDialog({
    super.key,
    this.dosen,
  });

  @override
  State<DosenFormDialog> createState() => _DosenFormDialogState();
}

class _DosenFormDialogState extends State<DosenFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nidnController;
  late final TextEditingController _namaController;
  late final TextEditingController _alamatController;

  bool get _isEditing => widget.dosen != null;

  @override
  void initState() {
    super.initState();
    _nidnController = TextEditingController(text: widget.dosen?.nidn ?? '');
    _namaController = TextEditingController(text: widget.dosen?.nama ?? '');
    _alamatController = TextEditingController(text: widget.dosen?.alamat ?? '');
  }

  @override
  void dispose() {
    _nidnController.dispose();
    _namaController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _submitForm() {
    print('Submit form called');
    if (_formKey.currentState!.validate()) {
      print('Form valid, creating dosen');
      final dosen = Dosen(
        nidn: _nidnController.text.trim(),
        nama: _namaController.text.trim(),
        alamat: _alamatController.text.trim(),
      );
      print('Popping dosen: ${dosen.nama}');
      Navigator.of(context).pop(dosen);
    } else {
      print('Form invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Dosen' : 'Tambah Dosen'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NIDN Field
              TextFormField(
                controller: _nidnController,
                decoration: const InputDecoration(
                  labelText: 'NIDN',
                  hintText: 'Masukkan NIDN',
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: InputValidators.validateNidn,
                enabled: !_isEditing, // NISN cannot be edited
              ),
              const SizedBox(height: 16),

              // Nama Field
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: InputValidators.validateNama,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Alamat Field
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  hintText: 'Masukkan alamat lengkap',
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 3,
                validator: InputValidators.validateAlamat,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(_isEditing ? 'Simpan' : 'Tambah'),
        ),
      ],
    );
  }
}