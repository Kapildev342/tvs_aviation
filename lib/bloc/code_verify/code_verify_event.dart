part of 'code_verify_bloc.dart';

class CodeVerifyEvent extends Equatable {
  const CodeVerifyEvent();

  @override
  List<Object?> get props => [];
}

class CodeVerifyInitialEvent extends CodeVerifyEvent {
  const CodeVerifyInitialEvent();
  @override
  List<Object?> get props => [];
}

class CodeVerifyTimerEvent extends CodeVerifyEvent {
  final bool response;
  const CodeVerifyTimerEvent({required this.response});
  @override
  List<Object?> get props => [response];
}

class OtpValidatingEvent extends CodeVerifyEvent {
  final String email;
  const OtpValidatingEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class ResendCodeEvent extends CodeVerifyEvent {
  final String email;
  const ResendCodeEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
