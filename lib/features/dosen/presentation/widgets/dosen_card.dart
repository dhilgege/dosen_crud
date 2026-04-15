import 'package:flutter/material.dart';

import '../../domain/entities/dosen.dart';

/// Card widget to display dosen information
class DosenCard extends StatelessWidget {
  final Dosen dosen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DosenCard({
    super.key,
    required this.dosen,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NISN
            Row(
              children: [
                const Icon(Icons.badge, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'NIDN: ${dosen.nidn}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Nama
            Row(
              children: [
                const Icon(Icons.person, size: 20, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dosen.nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Alamat
            Row(
              children: [
                const Icon(Icons.location_on, size: 20, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dosen.alamat,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi Hapus'),
                        content: Text(
                          'Apakah Anda yakin ingin menghapus dosen ${dosen.nama}?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      onDelete();
                    }
                  },
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Hapus'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}