import '../entities/dosen.dart';

/// Abstract repository interface for Dosen operations
/// Defines the contract for data access operations
abstract class DosenRepository {
  /// Get all dosen from the data source
  Future<List<Dosen>> getAllDosen();

  /// Add a new dosen to the data source
  Future<void> addDosen(Dosen dosen);

  /// Update an existing dosen in the data source
  Future<void> updateDosen(Dosen dosen);

  /// Delete a dosen from the data source by NIDN
  Future<void> deleteDosen(String nidn);
}