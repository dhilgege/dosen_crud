import 'package:equatable/equatable.dart';

/// Domain entity representing a lecturer (Dosen)
/// Contains the core business data without any implementation details
class Dosen extends Equatable {
  final String nidn;
  final String nama;
  final String alamat;

  const Dosen({
    required this.nidn,
    required this.nama,
    required this.alamat,
  });

  @override
  List<Object?> get props => [nidn, nama, alamat];
}