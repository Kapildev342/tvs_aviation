part of 'reports_bloc.dart';

class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class ReportsInitialEvent extends ReportsEvent {
  const ReportsInitialEvent();

  @override
  List<Object?> get props => [];
}

class ReportsPageChangingEvent extends ReportsEvent {
  final int index;
  const ReportsPageChangingEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class CalenderEnablingEvent extends ReportsEvent {
  const CalenderEnablingEvent();

  @override
  List<Object?> get props => [];
}

class CalenderSelectionEvent extends ReportsEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  const CalenderSelectionEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class LocationSelectionAllEvent extends ReportsEvent {
  final bool isAllCheck;
  const LocationSelectionAllEvent({required this.isAllCheck});

  @override
  List<Object?> get props => [isAllCheck];
}

class LocationSelectionSingleEvent extends ReportsEvent {
  final int selectedIndex;
  final bool selectedIndexValue;
  const LocationSelectionSingleEvent({required this.selectedIndex, required this.selectedIndexValue});

  @override
  List<Object?> get props => [selectedIndex, selectedIndexValue];
}

class ReportsFilterEvent extends ReportsEvent {
  const ReportsFilterEvent();
  @override
  List<Object?> get props => [];
}

class DownloadFileEvent extends ReportsEvent {
  const DownloadFileEvent();
  @override
  List<Object?> get props => [];
}
