part of 'manual_bloc.dart';

class ManualEvent extends Equatable {
  const ManualEvent();

  @override
  List<Object?> get props => [];
}

class ManualInitialEvent extends ManualEvent {
  const ManualInitialEvent();

  @override
  List<Object?> get props => [];
}

class ManualChangingEvent extends ManualEvent {
  final BuildContext context;
  const ManualChangingEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
