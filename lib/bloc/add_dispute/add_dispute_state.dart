part of 'add_dispute_bloc.dart';

class AddDisputeState extends Equatable {
  const AddDisputeState();

  @override
  List<Object?> get props => [];
}

class AddDisputeLoading extends AddDisputeState {
  const AddDisputeLoading();
  @override
  List<Object> get props => [];
}

class AddDisputeLoaded extends AddDisputeState {
  const AddDisputeLoaded();
  @override
  List<Object> get props => [];
}

class AddDisputeSuccess extends AddDisputeState {
  final String message;
  const AddDisputeSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class AddDisputeFailure extends AddDisputeState {
  final String errorMessage;
  const AddDisputeFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class AddDisputeError extends AddDisputeState {
  const AddDisputeError();
  @override
  List<Object> get props => [];
}

class AddDisputeDummy extends AddDisputeState {
  const AddDisputeDummy();
  @override
  List<Object> get props => [];
}
