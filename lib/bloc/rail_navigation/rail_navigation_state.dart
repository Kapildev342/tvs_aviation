part of 'rail_navigation_bloc.dart';

sealed class RailNavigationState extends Equatable {
  const RailNavigationState();
}

final class RailNavigationLoading extends RailNavigationState {
  @override
  List<Object> get props => [];
}

final class RailNavigationLoaded extends RailNavigationState {
  @override
  List<Object> get props => [];
}

final class RailNavigationDummy extends RailNavigationState {
  @override
  List<Object> get props => [];
}

class RailNavigationSuccess extends RailNavigationState {
  final String message;
  const RailNavigationSuccess({required this.message});
  @override
  List<Object> get props => [];
}

class RailNavigationFailure extends RailNavigationState {
  final String errorMessage;
  const RailNavigationFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class RailNavigationError extends RailNavigationState {
  @override
  List<Object> get props => [];
}
