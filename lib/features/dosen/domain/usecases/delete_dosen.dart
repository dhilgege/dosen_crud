import '../repositories/dosen_repository.dart';

/// Use case for deleting a dosen
/// Encapsulates the business logic for removing lecturer data
class DeleteDosen {
  final DosenRepository repository;

  DeleteDosen(this.repository);

  /// Execute the use case to delete a dosen by NIDN
  Future<void> call(String nidn) async {
    await repository.deleteDosen(nidn);
  }
}