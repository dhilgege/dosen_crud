import 'package:equatable/equatable.dart';

import '../../domain/entities/dosen.dart';

/// Base class for all Dosen states
abstract class DosenState extends Equatable {
  const DosenState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is first created
class DosenInitial extends DosenState {}

/// State when data is being loaded
class DosenLoading extends DosenState {}

/// State when data has been successfully loaded
class DosenLoaded extends DosenState {
  final List<Dosen> dosenList;

  const DosenLoaded(this.dosenList);

  @override
  List<Object?> get props => [dosenList];
}

/// State when an error occurs
class DosenError extends DosenState {
  final String message;

  const DosenError(this.message);

  @override
  List<Object?> get props => [message];
}