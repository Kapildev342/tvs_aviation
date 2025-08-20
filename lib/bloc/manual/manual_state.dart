part of 'manual_bloc.dart';

class ManualState extends Equatable {
  const ManualState();

  @override
  List<Object?> get props => [];
}

class ManualLoading extends ManualState {
  const ManualLoading();
  @override
  List<Object> get props => [];
}

class ManualLoaded extends ManualState {
  const ManualLoaded();
  @override
  List<Object> get props => [];
}

class ManualSuccess extends ManualState {
  final String message;
  const ManualSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ManualFailure extends ManualState {
  final String errorMessage;
  const ManualFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ManualError extends ManualState {
  const ManualError();
  @override
  List<Object> get props => [];
}

class ManualDummy extends ManualState {
  const ManualDummy();
  @override
  List<Object> get props => [];
}
