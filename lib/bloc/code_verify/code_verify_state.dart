part of 'code_verify_bloc.dart';

sealed class CodeVerifyState extends Equatable {
  const CodeVerifyState();
}

final class CodeVerifyLoading extends CodeVerifyState {
  @override
  List<Object> get props => [];
}

final class CodeVerifyLoaded extends CodeVerifyState {
  const CodeVerifyLoaded();
  @override
  List<Object> get props => [];
}

final class CodeVerifyDummy extends CodeVerifyState {
  @override
  List<Object> get props => [];
}

final class CodeVerifySuccess extends CodeVerifyState {
  final String message;
  const CodeVerifySuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class CodeVerifyResendSuccess extends CodeVerifyState {
  final String message;
  const CodeVerifyResendSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class CodeVerifyError extends CodeVerifyState {
  @override
  List<Object> get props => [];
}

final class CodeVerifyFailure extends CodeVerifyState {
  final String errorMessage;
  const CodeVerifyFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
