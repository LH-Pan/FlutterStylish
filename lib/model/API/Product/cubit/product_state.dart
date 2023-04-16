part of 'product_cubit.dart';

@immutable
abstract class FetchState {}

class FetchInitialState extends FetchState {}

class FetchLoadingState extends FetchState {}

class FetchSuccessState<T> extends FetchState {

  final T data;

  FetchSuccessState(this.data);
}

class FetchErrorState extends FetchState {

  final String errorMsg;

  FetchErrorState(this.errorMsg);
}