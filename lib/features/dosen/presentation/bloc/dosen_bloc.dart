import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_dosen.dart';
import '../../domain/usecases/delete_dosen.dart';
import '../../domain/usecases/get_all_dosen.dart';
import '../../domain/usecases/update_dosen.dart';
import 'dosen_event.dart';
import 'dosen_state.dart';

/// Bloc for managing Dosen-related state and business logic
class DosenBloc extends Bloc<DosenEvent, DosenState> {
  final GetAllDosen getAllDosen;
  final AddDosen addDosen;
  final UpdateDosen updateDosen;
  final DeleteDosen deleteDosen;

  DosenBloc({
    required this.getAllDosen,
    required this.addDosen,
    required this.updateDosen,
    required this.deleteDosen,
  }) : super(DosenInitial()) {
    on<LoadDosen>(_onLoadDosen);
    on<AddDosenEvent>(_onAddDosen);
    on<UpdateDosenEvent>(_onUpdateDosen);
    on<DeleteDosenEvent>(_onDeleteDosen);
  }

  /// Handler for LoadDosen event
  Future<void> _onLoadDosen(LoadDosen event, Emitter<DosenState> emit) async {
    emit(DosenLoading());
    try {
      final dosenList = await getAllDosen();
      emit(DosenLoaded(dosenList));
    } catch (e) {
      emit(DosenError(e.toString()));
    }
  }

  /// Handler for AddDosenEvent
  Future<void> _onAddDosen(AddDosenEvent event, Emitter<DosenState> emit) async {
    print('Adding dosen: ${event.dosen.nama}, NIDN: ${event.dosen.nidn}');
    if (state is DosenLoaded) {
      final currentState = state as DosenLoaded;
      emit(DosenLoading());
      try {
        await addDosen(event.dosen);
        final updatedList = await getAllDosen();
        print('After add, list has ${updatedList.length} items');
        emit(DosenLoaded(updatedList));
      } catch (e) {
        print('Error adding dosen: $e');
        emit(DosenError(e.toString()));
        // Revert to previous state if add fails
        emit(currentState);
      }
    }
  }

  /// Handler for UpdateDosenEvent
  Future<void> _onUpdateDosen(UpdateDosenEvent event, Emitter<DosenState> emit) async {
    if (state is DosenLoaded) {
      final currentState = state as DosenLoaded;
      emit(DosenLoading());
      try {
        await updateDosen(event.dosen);
        final updatedList = await getAllDosen();
        emit(DosenLoaded(updatedList));
      } catch (e) {
        emit(DosenError(e.toString()));
        // Revert to previous state if update fails
        emit(currentState);
      }
    }
  }

  /// Handler for DeleteDosenEvent
  Future<void> _onDeleteDosen(DeleteDosenEvent event, Emitter<DosenState> emit) async {
    if (state is DosenLoaded) {
      final currentState = state as DosenLoaded;
      emit(DosenLoading());
      try {
        await deleteDosen(event.nidn);
        final updatedList = await getAllDosen();
        emit(DosenLoaded(updatedList));
      } catch (e) {
        emit(DosenError(e.toString()));
        // Revert to previous state if delete fails
        emit(currentState);
      }
    }
  }
}