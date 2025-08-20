part of 'check_list_bloc.dart';

class CheckListEvent extends Equatable {
  const CheckListEvent();

  @override
  List<Object?> get props => [];
}

class CheckListPageInitialEvent extends CheckListEvent {
  const CheckListPageInitialEvent();

  @override
  List<Object?> get props => [];
}

class CheckListPageChangingEvent extends CheckListEvent {
  final int index;
  const CheckListPageChangingEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class CheckListAddEvent extends CheckListEvent {
  const CheckListAddEvent();

  @override
  List<Object?> get props => [];
}
