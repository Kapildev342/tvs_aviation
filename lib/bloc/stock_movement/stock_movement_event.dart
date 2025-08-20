part of 'stock_movement_bloc.dart';

class StockMovementEvent extends Equatable {
  const StockMovementEvent();

  @override
  List<Object?> get props => [];
}

class StockMovementInitialEvent extends StockMovementEvent {
  const StockMovementInitialEvent();

  @override
  List<Object?> get props => [];
}

class StockMovementTableChangingEvent extends StockMovementEvent {
  const StockMovementTableChangingEvent();

  @override
  List<Object?> get props => [];
}
