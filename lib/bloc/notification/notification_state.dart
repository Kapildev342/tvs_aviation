part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
}

final class NotificationLoading extends NotificationState {
  const NotificationLoading();
  @override
  List<Object> get props => [];
}

final class NotificationLoaded extends NotificationState {
  const NotificationLoaded();
  @override
  List<Object> get props => [];
}

final class NotificationFailure extends NotificationState {
  final String errorMessage;
  const NotificationFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class NotificationError extends NotificationState {
  const NotificationError();
  @override
  List<Object> get props => [];
}

final class NotificationSuccess extends NotificationState {
  const NotificationSuccess();
  @override
  List<Object> get props => [];
}

final class NotificationDummy extends NotificationState {
  const NotificationDummy();
  @override
  List<Object> get props => [];
}
