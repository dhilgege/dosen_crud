import '../entities/dosen.dart';
import '../repositories/dosen_repository.dart';

/// Use case for updating an existing dosen
/// Encapsulates the business logic for modifying lecturer data
class UpdateDosen {
  final DosenRepository repository;

  UpdateDosen(this.repository);

  /// Execute the use case to update an existing dosen
  Future<void> call(Dosen dosen) async {
    await repository.updateDosen(dosen);
  }
}