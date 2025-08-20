part of 'notification_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationInitialEvent extends NotificationEvent {
  final String locationId;
  final int index;

  const NotificationInitialEvent({required this.locationId, required this.index});

  @override
  List<Object?> get props => [locationId, index];
}

class NotificationReadEvent extends NotificationEvent {
  final String notificationId;
  final int index;
  final String category;
  const NotificationReadEvent({required this.notificationId, required this.index, required this.category});

  @override
  List<Object?> get props => [notificationId, index, category];
}
