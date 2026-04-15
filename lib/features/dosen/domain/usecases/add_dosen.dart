import '../entities/dosen.dart';
import '../repositories/dosen_repository.dart';

/// Use case for adding a new dosen
/// Encapsulates the business logic for creating new lecturer data
class AddDosen {
  final DosenRepository repository;

  AddDosen(this.repository);

  /// Execute the use case to add a new dosen
  Future<void> call(Dosen dosen) async {
    await repository.addDosen(dosen);
  }
}