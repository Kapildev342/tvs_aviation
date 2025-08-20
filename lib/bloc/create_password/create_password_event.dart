part of 'create_password_bloc.dart';

class CreatePasswordEvent extends Equatable {
  const CreatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class CreateNewPasswordVisibleEvent extends CreatePasswordEvent {
  const CreateNewPasswordVisibleEvent();

  @override
  List<Object?> get props => [];
}

class CreateConfirmPasswordVisibleEvent extends CreatePasswordEvent {
  const CreateConfirmPasswordVisibleEvent();

  @override
  List<Object?> get props => [];
}

class CreatePasswordButtonEvent extends CreatePasswordEvent {
  final String email;
  const CreatePasswordButtonEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordValidatingEvent extends CreatePasswordEvent {
  const PasswordValidatingEvent();

  @override
  List<Object?> get props => [];
}

class RefreshEvent extends CreatePasswordEvent {
  const RefreshEvent();

  @override
  List<Object?> get props => [];
}

class ProgressBarEvent extends CreatePasswordEvent {
  final String value;
  const ProgressBarEvent({required this.value});
  @override
  List<Object?> get props => [value];
}
