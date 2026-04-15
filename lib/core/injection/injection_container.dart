import 'package:get_it/get_it.dart';

import '../../features/dosen/data/datasources/dosen_local_data_source.dart';
import '../../features/dosen/data/repositories/dosen_repository_impl.dart';
import '../../features/dosen/domain/repositories/dosen_repository.dart';
import '../../features/dosen/domain/usecases/add_dosen.dart';
import '../../features/dosen/domain/usecases/delete_dosen.dart';
import '../../features/dosen/domain/usecases/get_all_dosen.dart';
import '../../features/dosen/domain/usecases/update_dosen.dart';
import '../../features/dosen/presentation/bloc/dosen_bloc.dart';

/// Dependency Injection Container
/// Registers all dependencies for the application
final sl = GetIt.instance;

Future<void> init() async {
  // Features - Dosen

  // Bloc
  sl.registerFactory(
    () => DosenBloc(
      getAllDosen: sl(),
      addDosen: sl(),
      updateDosen: sl(),
      deleteDosen: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllDosen(sl()));
  sl.registerLazySingleton(() => AddDosen(sl()));
  sl.registerLazySingleton(() => UpdateDosen(sl()));
  sl.registerLazySingleton(() => DeleteDosen(sl()));

  // Repository
  sl.registerLazySingleton<DosenRepository>(
    () => DosenRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<DosenLocalDataSource>(
    () => DosenLocalDataSourceImpl(),
  );
}