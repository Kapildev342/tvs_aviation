part of 'forget_password_bloc.dart';

class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class CodeSendingEvent extends ForgetPasswordEvent {
  const CodeSendingEvent();

  @override
  List<Object?> get props => [];
}
