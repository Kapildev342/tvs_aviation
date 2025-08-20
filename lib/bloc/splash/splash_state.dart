part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashLoading extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashLoaded extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashDummy extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashSuccess extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashFailure extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashError extends SplashState {
  @override
  List<Object> get props => [];
}
