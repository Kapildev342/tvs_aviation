part of 'inventory_bloc.dart';

class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object?> get props => [];
}

class InventoryInitialEvent extends InventoryEvent {
  final StateSetter modelSetState;
  final BuildContext context;
  const InventoryInitialEvent({required this.modelSetState, required this.context});

  @override
  List<Object?> get props => [modelSetState, context];
}

class InventoryChangeEvent extends InventoryEvent {
  final StateSetter modelSetState;
  const InventoryChangeEvent({required this.modelSetState});

  @override
  List<Object?> get props => [modelSetState];
}

class InventorySearchEvent extends InventoryEvent {
  final StateSetter modelSetState;
  const InventorySearchEvent({required this.modelSetState});

  @override
  List<Object?> get props => [modelSetState];
}

class InventoryDataEvent extends InventoryEvent {
  final StateSetter modelSetState;
  final String productId;
  final String productName;
  final bool productHasExpiry;
  const InventoryDataEvent({required this.modelSetState, required this.productId, required this.productName, required this.productHasExpiry});

  @override
  List<Object?> get props => [modelSetState, productId, productName, productHasExpiry];
}

class InventorySearchDataEvent extends InventoryEvent {
  final StateSetter modelSetState;
  const InventorySearchDataEvent({required this.modelSetState});
  @override
  List<Object?> get props => [];
}

class InventoryUpdateDataEvent extends InventoryEvent {
  final StateSetter modelSetState;
  const InventoryUpdateDataEvent({required this.modelSetState});
  @override
  List<Object?> get props => [modelSetState];
}

class MinimumLevelUpdateEvent extends InventoryEvent {
  final int updateLevel;
  final StateSetter modelSetState;
  const MinimumLevelUpdateEvent({required this.updateLevel, required this.modelSetState});

  @override
  List<Object?> get props => [updateLevel, modelSetState];
}

class QuantityUpdateEvent extends InventoryEvent {
  final int index;
  final StateSetter modelSetState;
  const QuantityUpdateEvent({required this.index, required this.modelSetState});

  @override
  List<Object?> get props => [index, modelSetState];
}

/*
class GetCartEvent extends InventoryEvent {
  const GetCartEvent();

  @override
  List<Object?> get props => [];
}
*/

class UpdateCartEvent extends InventoryEvent {
  final StateSetter modelSetState;
  final BuildContext context;
  const UpdateCartEvent({required this.modelSetState,required this.context});

  @override
  List<Object?> get props => [modelSetState,context];
}

class CartActionEvent extends InventoryEvent {
  final String cardId;
  final String action;
  final String remarks;
  final BuildContext context;
  final StateSetter modelSetState;
  const CartActionEvent({required this.cardId, required this.action,required this.remarks,required this.context,required this.modelSetState});

  @override
  List<Object?> get props => [cardId,action,remarks,context,modelSetState];
}
