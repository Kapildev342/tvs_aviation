part of 'confirm_movement_bloc.dart';

class ConfirmMovementState extends Equatable {
  const ConfirmMovementState();

  @override
  List<Object?> get props => [];
}

class ConfirmMovementLoading extends ConfirmMovementState {
  const ConfirmMovementLoading();
  @override
  List<Object> get props => [];
}

class ConfirmMovementLoaded extends ConfirmMovementState {
  const ConfirmMovementLoaded();
  @override
  List<Object> get props => [];
}

class ConfirmMovementSuccess extends ConfirmMovementState {
  final String message;
  const ConfirmMovementSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ConfirmMovementFailure extends ConfirmMovementState {
  final String errorMessage;
  const ConfirmMovementFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ConfirmMovementError extends ConfirmMovementState {
  const ConfirmMovementError();
  @override
  List<Object> get props => [];
}

class ConfirmMovementDummy extends ConfirmMovementState {
  const ConfirmMovementDummy();
  @override
  List<Object> get props => [];
}
