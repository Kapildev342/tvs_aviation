part of 'stock_movement_bloc.dart';

class StockMovementState extends Equatable {
  const StockMovementState();

  @override
  List<Object?> get props => [];
}

final class StockMovementLoading extends StockMovementState {
  const StockMovementLoading();
  @override
  List<Object> get props => [];
}

final class StockMovementLoaded extends StockMovementState {
  const StockMovementLoaded();
  @override
  List<Object> get props => [];
}

final class StockMovementSuccess extends StockMovementState {
  const StockMovementSuccess();
  @override
  List<Object> get props => [];
}

final class StockMovementFailure extends StockMovementState {
  final String errorMessage;
  const StockMovementFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class StockMovementError extends StockMovementState {
  const StockMovementError();
  @override
  List<Object> get props => [];
}

final class StockMovementDummy extends StockMovementState {
  const StockMovementDummy();
  @override
  List<Object> get props => [];
}
