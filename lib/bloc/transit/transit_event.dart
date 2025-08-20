part of 'transit_bloc.dart';

class TransitEvent extends Equatable {
  const TransitEvent();

  @override
  List<Object?> get props => [];
}

class TransitInitialEvent extends TransitEvent {
  const TransitInitialEvent();
  @override
  List<Object?> get props => [];
}

class TransitFilterEvent extends TransitEvent {
  const TransitFilterEvent();
  @override
  List<Object?> get props => [];
}

class DownloadFileEvent extends TransitEvent {
  const DownloadFileEvent();
  @override
  List<Object?> get props => [];
}

class CalenderEnablingTransitEvent extends TransitEvent {
  const CalenderEnablingTransitEvent();

  @override
  List<Object?> get props => [];
}

class CalenderSelectionTransitEvent extends TransitEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  const CalenderSelectionTransitEvent({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class LocationSelectionAllTransitEvent extends TransitEvent {
  final bool isAllCheck;
  const LocationSelectionAllTransitEvent({required this.isAllCheck});

  @override
  List<Object?> get props => [isAllCheck];
}

class LocationSelectionSingleTransitEvent extends TransitEvent {
  final int selectedIndex;
  final bool selectedIndexValue;
  const LocationSelectionSingleTransitEvent({required this.selectedIndex, required this.selectedIndexValue});

  @override
  List<Object?> get props => [selectedIndex, selectedIndexValue];
}
