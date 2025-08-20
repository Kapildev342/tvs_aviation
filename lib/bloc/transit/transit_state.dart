part of 'transit_bloc.dart';

class TransitState extends Equatable {
  const TransitState();

  @override
  List<Object?> get props => [];
}

class TransitLoading extends TransitState {
  const TransitLoading();
  @override
  List<Object> get props => [];
}

class TransitLoaded extends TransitState {
  const TransitLoaded();
  @override
  List<Object> get props => [];
}

class TransitSuccess extends TransitState {
  final String message;
  const TransitSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class TransitFailure extends TransitState {
  final String errorMessage;
  const TransitFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class TransitError extends TransitState {
  const TransitError();
  @override
  List<Object> get props => [];
}

class TransitDummy extends TransitState {
  const TransitDummy();
  @override
  List<Object> get props => [];
}
