part of 'stock_dispute_bloc.dart';

class StockDisputeState extends Equatable {
  const StockDisputeState();

  @override
  List<Object?> get props => [];
}

class StockDisputeLoading extends StockDisputeState {
  const StockDisputeLoading();
  @override
  List<Object> get props => [];
}

class StockDisputeLoaded extends StockDisputeState {
  const StockDisputeLoaded();
  @override
  List<Object> get props => [];
}

class StockDisputeSuccess extends StockDisputeState {
  final String message;
  const StockDisputeSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class StockDisputeError extends StockDisputeState {
  const StockDisputeError();
  @override
  List<Object> get props => [];
}

class StockDisputeFailure extends StockDisputeState {
  final String errorMessage;
  const StockDisputeFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class StockDisputeDummy extends StockDisputeState {
  const StockDisputeDummy();
  @override
  List<Object> get props => [];
}
