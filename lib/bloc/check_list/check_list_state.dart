part of 'check_list_bloc.dart';

sealed class CheckListState extends Equatable {
  const CheckListState();
}

class CheckListLoading extends CheckListState {
  const CheckListLoading();
  @override
  List<Object> get props => [];
}

class CheckListLoaded extends CheckListState {
  const CheckListLoaded();
  @override
  List<Object> get props => [];
}

class CheckListSuccess extends CheckListState {
  final String message;
  const CheckListSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class CheckListFailure extends CheckListState {
  final String errorMessage;
  const CheckListFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CheckListError extends CheckListState {
  const CheckListError();
  @override
  List<Object> get props => [];
}

class CheckListDummy extends CheckListState {
  const CheckListDummy();
  @override
  List<Object> get props => [];
}
