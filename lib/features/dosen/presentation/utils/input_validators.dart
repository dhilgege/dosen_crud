/// Input validation utilities for Dosen form
class InputValidators {
  /// Validate NIDN field
  static String? validateNidn(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIDN tidak boleh kosong';
    }
    if (value.length < 10) {
      return 'NIDN minimal 10 karakter';
    }
    if (value.length > 20) {
      return 'NIDN maksimal 20 karakter';
    }
    // Check if contains only numbers
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'NIDN hanya boleh berisi angka';
    }
    return null;
  }

  /// Validate Nama field
  static String? validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    if (value.length > 100) {
      return 'Nama maksimal 100 karakter';
    }
    return null;
  }

  /// Validate Alamat field
  static String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }
    if (value.length < 5) {
      return 'Alamat minimal 5 karakter';
    }
    if (value.length > 500) {
      return 'Alamat maksimal 500 karakter';
    }
    return null;
  }
}