import 'package:equatable/equatable.dart';

import '../../domain/entities/dosen.dart';

/// Base class for all Dosen events
abstract class DosenEvent extends Equatable {
  const DosenEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all dosen
class LoadDosen extends DosenEvent {}

/// Event to add a new dosen
class AddDosenEvent extends DosenEvent {
  final Dosen dosen;

  const AddDosenEvent(this.dosen);

  @override
  List<Object?> get props => [dosen];
}

/// Event to update an existing dosen
class UpdateDosenEvent extends DosenEvent {
  final Dosen dosen;

  const UpdateDosenEvent(this.dosen);

  @override
  List<Object?> get props => [dosen];
}

/// Event to delete a dosen by NIDN
class DeleteDosenEvent extends DosenEvent {
  final String nidn;

  const DeleteDosenEvent(this.nidn);

  @override
  List<Object?> get props => [nidn];
}