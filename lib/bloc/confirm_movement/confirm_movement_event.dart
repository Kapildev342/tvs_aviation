part of 'confirm_movement_bloc.dart';

class ConfirmMovementEvent extends Equatable {
  const ConfirmMovementEvent();

  @override
  List<Object?> get props => [];
}

class ConfirmMovementCreateEvent extends ConfirmMovementEvent {
  final StateSetter modelSetState;
  const ConfirmMovementCreateEvent({required this.modelSetState});

  @override
  List<Object?> get props => [modelSetState];
}
