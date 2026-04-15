import '../../domain/entities/dosen.dart';
import '../../domain/repositories/dosen_repository.dart';
import '../datasources/dosen_local_data_source.dart';
import '../models/dosen_model.dart';

/// Implementation of DosenRepository interface
/// Acts as a bridge between domain layer and data layer
class DosenRepositoryImpl implements DosenRepository {
  final DosenLocalDataSource localDataSource;

  DosenRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Dosen>> getAllDosen() async {
    try {
      final dosenModels = await localDataSource.getAllDosen();
      return dosenModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get all dosen: $e');
    }
  }

  @override
  Future<void> addDosen(Dosen dosen) async {
    try {
      final dosenModel = DosenModel.fromEntity(dosen);
      await localDataSource.addDosen(dosenModel);
    } catch (e) {
      throw Exception('Failed to add dosen: $e');
    }
  }

  @override
  Future<void> updateDosen(Dosen dosen) async {
    try {
      final dosenModel = DosenModel.fromEntity(dosen);
      await localDataSource.updateDosen(dosenModel);
    } catch (e) {
      throw Exception('Failed to update dosen: $e');
    }
  }

  @override
  Future<void> deleteDosen(String nidn) async {
    try {
      await localDataSource.deleteDosen(nidn);
    } catch (e) {
      throw Exception('Failed to delete dosen: $e');
    }
  }
}