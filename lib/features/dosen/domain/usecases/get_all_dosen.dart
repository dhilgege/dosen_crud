import '../entities/dosen.dart';
import '../repositories/dosen_repository.dart';

/// Use case for getting all dosen
/// Encapsulates the business logic for retrieving all lecturer data
class GetAllDosen {
  final DosenRepository repository;

  GetAllDosen(this.repository);

  /// Execute the use case to get all dosen
  Future<List<Dosen>> call() async {
    return await repository.getAllDosen();
  }
}