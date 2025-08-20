part of 'manage_bloc.dart';

class ManageState extends Equatable {
  const ManageState();

  @override
  List<Object?> get props => [];
}

class ManageLoading extends ManageState {
  const ManageLoading();
  @override
  List<Object> get props => [];
}

class ManageLoaded extends ManageState {
  const ManageLoaded();
  @override
  List<Object> get props => [];
}

class ManageDummy extends ManageState {
  const ManageDummy();
  @override
  List<Object> get props => [];
}

class ManageSuccess extends ManageState {
  final String message;
  const ManageSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ManageSuccess2 extends ManageState {
  final String message;
  const ManageSuccess2({required this.message});
  @override
  List<Object> get props => [message];
}

class ManageFailure extends ManageState {
  final String errorMessage;
  const ManageFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ManageError extends ManageState {
  const ManageError();
  @override
  List<Object> get props => [];
}
