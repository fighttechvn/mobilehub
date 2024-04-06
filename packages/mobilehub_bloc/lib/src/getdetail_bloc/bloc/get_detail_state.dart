part of 'get_detail_bloc.dart';

@immutable
abstract class GetDetailState {}

class GetDetailInitial extends GetDetailState {}

class GetDetailDataLoading<T> extends GetDetailState {}

class GetDetailDataSuccess<T> extends GetDetailState {
  final T data;
  GetDetailDataSuccess(this.data);
}

class GetDetailError<T> extends GetDetailState {
  final dynamic error;

  GetDetailError(this.error);
}

class GetDetailErrorHasData<T> extends GetDetailDataSuccess {
  final dynamic error;

  GetDetailErrorHasData(super.data, this.error);
}
