part of 'forget_password_bloc.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
}

final class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgetPasswordLoaded extends ForgetPasswordState {
  const ForgetPasswordLoaded();
  @override
  List<Object> get props => [];
}

final class ForgetPasswordDummy extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class ForgetPasswordError extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String errorMessage;
  const ForgetPasswordFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
