part of 'reports_bloc.dart';

class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReportsLoading extends ReportsState {
  const ReportsLoading();
  @override
  List<Object> get props => [];
}

class ReportsLoaded extends ReportsState {
  const ReportsLoaded();
  @override
  List<Object> get props => [];
}

class ReportsDummy extends ReportsState {
  const ReportsDummy();
  @override
  List<Object> get props => [];
}

class ReportsSuccess extends ReportsState {
  final String message;
  const ReportsSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class ReportsFailure extends ReportsState {
  final String errorMessage;
  const ReportsFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ReportsError extends ReportsState {
  const ReportsError();
  @override
  List<Object> get props => [];
}
