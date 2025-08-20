part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
  @override
  List<Object> get props => [];
}

final class HomeLoaded extends HomeState {
  const HomeLoaded();
  @override
  List<Object> get props => [];
}

final class HomeSuccess extends HomeState {
  const HomeSuccess();
  @override
  List<Object> get props => [];
}

final class HomeFailure extends HomeState {
  final String errorMessage;
  const HomeFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class HomeError extends HomeState {
  const HomeError();
  @override
  List<Object> get props => [];
}

final class HomeDummy extends HomeState {
  const HomeDummy();
  @override
  List<Object> get props => [];
}
