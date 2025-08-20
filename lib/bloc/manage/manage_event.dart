part of 'manage_bloc.dart';

class ManageEvent extends Equatable {
  const ManageEvent();

  @override
  List<Object?> get props => [];
}

class ManagePageChangingEvent extends ManageEvent {
  final int index;
  final String? withinScreen;
  const ManagePageChangingEvent({required this.index, this.withinScreen});

  @override
  List<Object?> get props => [index, withinScreen];
}

class ManagePageFilterEvent extends ManageEvent {
  const ManagePageFilterEvent();

  @override
  List<Object?> get props => [];
}

class ManageCalenderEnablingEvent extends ManageEvent {
  const ManageCalenderEnablingEvent();

  @override
  List<Object?> get props => [];
}

class InventoryBulkUploadEvent extends ManageEvent {
  final StateSetter setState;
  const InventoryBulkUploadEvent({required this.setState});

  @override
  List<Object?> get props => [setState];
}

class GetProductDetailsEvent extends ManageEvent {
  const GetProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

class CsvFileSelectionEvent extends ManageEvent {
  final StateSetter setState;
  final BuildContext context;
  const CsvFileSelectionEvent({required this.setState, required this.context});

  @override
  List<Object?> get props => [setState, context];
}

class AddBrandTypeEvent extends ManageEvent {
  const AddBrandTypeEvent();

  @override
  List<Object?> get props => [];
}

class DeleteBrandTypeEvent extends ManageEvent {
  final int index;
  const DeleteBrandTypeEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditBrandTypeEvent extends ManageEvent {
  final int index;
  const EditBrandTypeEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddCategoryEvent extends ManageEvent {
  const AddCategoryEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCategoryEvent extends ManageEvent {
  final int index;
  const DeleteCategoryEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditCategoryEvent extends ManageEvent {
  final int index;
  const EditCategoryEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddHandlerEvent extends ManageEvent {
  const AddHandlerEvent();

  @override
  List<Object?> get props => [];
}

class DeleteHandlerEvent extends ManageEvent {
  final int index;
  const DeleteHandlerEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditHandlerEvent extends ManageEvent {
  final int index;
  const EditHandlerEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddWarehouseOrAircraftEvent extends ManageEvent {
  const AddWarehouseOrAircraftEvent();

  @override
  List<Object?> get props => [];
}

class DeleteWarehouseOrAircraftEvent extends ManageEvent {
  final int index;
  const DeleteWarehouseOrAircraftEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditWarehouseOrAircraftEvent extends ManageEvent {
  final int index;
  const EditWarehouseOrAircraftEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddSectorEvent extends ManageEvent {
  const AddSectorEvent();

  @override
  List<Object?> get props => [];
}

class DeleteSectorEvent extends ManageEvent {
  final int index;
  const DeleteSectorEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditSectorEvent extends ManageEvent {
  final int index;
  const EditSectorEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddCrewEvent extends ManageEvent {
  const AddCrewEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCrewEvent extends ManageEvent {
  final int index;
  const DeleteCrewEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditCrewEvent extends ManageEvent {
  final int index;
  const EditCrewEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class CrewActivateEvent extends ManageEvent {
  final int index;
  const CrewActivateEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class CrewDeactivateEvent extends ManageEvent {
  final int index;
  const CrewDeactivateEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class AddProductEvent extends ManageEvent {
  final GlobalKey<EasyAutocompleteState> key4;
  final GlobalKey<EasyAutocompleteState> key5;
  const AddProductEvent({required this.key4, required this.key5});

  @override
  List<Object?> get props => [key4, key5];
}

class DeleteProductEvent extends ManageEvent {
  final int index;
  const DeleteProductEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditProductEvent extends ManageEvent {
  final int index;
  const EditProductEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ProductActivateEvent extends ManageEvent {
  final int index;
  const ProductActivateEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ProductDeactivateEvent extends ManageEvent {
  final int index;
  const ProductDeactivateEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class ProductMiniLevelExpiryEvent extends ManageEvent {
  const ProductMiniLevelExpiryEvent();

  @override
  List<Object?> get props => [];
}

class AddInventoryEvent extends ManageEvent {
  final GlobalKey<EasyAutocompleteState> key1;
  final GlobalKey<EasyAutocompleteState> key2;
  final GlobalKey<EasyAutocompleteState> key3;
  const AddInventoryEvent({required this.key1, required this.key2, required this.key3});

  @override
  List<Object?> get props => [key1, key2, key3];
}
