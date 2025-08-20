part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object?> get props => [];
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
  @override
  List<Object> get props => [];
}

class InventoryLoaded extends InventoryState {
  const InventoryLoaded();
  @override
  List<Object> get props => [];
}

class InventorySuccess extends InventoryState {
  final String message;
  const InventorySuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class InventoryFailure extends InventoryState {
  final String errorMessage;
  const InventoryFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class InventoryError extends InventoryState {
  const InventoryError();
  @override
  List<Object> get props => [];
}

class InventoryDummy extends InventoryState {
  const InventoryDummy();
  @override
  List<Object> get props => [];
}
