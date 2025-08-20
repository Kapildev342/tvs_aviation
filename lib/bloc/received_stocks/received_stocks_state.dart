part of 'received_stocks_bloc.dart';

class ReceivedStocksState extends Equatable {
  const ReceivedStocksState();
  @override
  List<Object?> get props => [];
}

class ReceivedStocksLoading extends ReceivedStocksState {
  const ReceivedStocksLoading();
  @override
  List<Object> get props => [];
}

class ReceivedStocksLoaded extends ReceivedStocksState {
  const ReceivedStocksLoaded();
  @override
  List<Object> get props => [];
}

class ReceivedStocksSuccess extends ReceivedStocksState {
  final String message;
  const ReceivedStocksSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ReceivedStocksFailure extends ReceivedStocksState {
  final String errorMessage;
  const ReceivedStocksFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ReceivedStocksError extends ReceivedStocksState {
  const ReceivedStocksError();
  @override
  List<Object> get props => [];
}

class ReceivedStocksDummy extends ReceivedStocksState {
  const ReceivedStocksDummy();
  @override
  List<Object> get props => [];
}
