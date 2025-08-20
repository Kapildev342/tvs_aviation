part of 'rail_navigation_bloc.dart';

class RailNavigationEvent extends Equatable {
  const RailNavigationEvent();

  @override
  List<Object?> get props => [];
}

class RailNavigationInitialEvent extends RailNavigationEvent {
  final StateSetter modelSetState;
  const RailNavigationInitialEvent({required this.modelSetState});

  @override
  List<Object?> get props => [modelSetState];
}

class RailNavigationSelectedWidgetEvent extends RailNavigationEvent {
  const RailNavigationSelectedWidgetEvent();

  @override
  List<Object?> get props => [];
}

class RailNavigationBackWidgetEvent extends RailNavigationEvent {
  const RailNavigationBackWidgetEvent();

  @override
  List<Object?> get props => [];
}

class EditProfileEvent extends RailNavigationEvent {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class PasswordToggleEvent extends RailNavigationEvent {
  final String type;
  const PasswordToggleEvent({required this.type});

  @override
  List<Object?> get props => [type];
}
