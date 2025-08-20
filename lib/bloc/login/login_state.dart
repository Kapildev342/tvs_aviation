part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
  @override
  List<Object> get props => [];
}

final class LoginDummy extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoaded extends LoginState {
  const LoginLoaded();
  @override
  List<Object> get props => [];
}

final class LoginSuccess extends LoginState {
  const LoginSuccess();
  @override
  List<Object> get props => [];
}

final class LoginError extends LoginState {
  const LoginError();
  @override
  List<Object> get props => [];
}

final class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
