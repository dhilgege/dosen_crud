import '../../domain/entities/dosen.dart';

/// Data model for Dosen that extends the domain entity
/// Includes JSON serialization methods for data transfer
class DosenModel extends Dosen {
  const DosenModel({
    required super.nidn,
    required super.nama,
    required super.alamat,
  });

  /// Factory constructor to create DosenModel from JSON
  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      nidn: json['nidn'] as String,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
    );
  }

  /// Convert DosenModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'nidn': nidn,
      'nama': nama,
      'alamat': alamat,
    };
  }

  /// Factory constructor to create DosenModel from Dosen entity
  factory DosenModel.fromEntity(Dosen dosen) {
    return DosenModel(
      nidn: dosen.nidn,
      nama: dosen.nama,
      alamat: dosen.alamat,
    );
  }

  /// Convert DosenModel to Dosen entity
  Dosen toEntity() {
    return Dosen(
      nidn: nidn,
      nama: nama,
      alamat: alamat,
    );
  }
}