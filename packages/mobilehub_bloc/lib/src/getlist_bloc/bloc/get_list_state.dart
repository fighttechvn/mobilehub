part of 'get_list_bloc.dart';

@immutable
abstract class GetListState extends Equatable {
  bool get isLoading =>
      this is GetListDataLoading || this is GetListBlocInitial;
}

class GetListBlocInitial extends GetListState {
  @override
  List<Object?> get props => [];
}

class GetListDataLoading<T> extends GetListState {
  @override
  List<Object?> get props => [];
}

class GetListDataSuccess<T> extends GetListState {
  final List<T> data;
  final int? timespan;

  GetListDataSuccess(this.data, {this.timespan});

  @override
  List<Object?> get props => [data, this.timespan];
}

class GetListDataLoadingSuccess<T> extends GetListDataSuccess<T> {
  GetListDataLoadingSuccess(super.data);
}

class GetListDataTypeSearchResult<T> extends GetListDataSuccess {
  final List<T> dataSearchResult;

  GetListDataTypeSearchResult(
    super.data,
    this.dataSearchResult,
  );
}

class GetListDataPagingSuccess<T, P2, P3> extends GetListDataSuccess<T> {
  final P2 offset;
  final P3 limit;
  final dynamic cursor;
  final bool hasLoadMore;

  GetListDataPagingSuccess(
    super.data, {
    required this.offset,
    required this.limit,
    this.hasLoadMore = true,
    super.timespan,
    this.cursor,
  });

  @override
  List<Object?> get props =>
      [data, offset, limit, hasLoadMore, timespan, cursor];
}

class GetListDataFromItemSuccess<T, P2, P3>
    extends GetListDataPagingSuccess<T, P2, P3> {
  final int index;

  GetListDataFromItemSuccess(
    super.data, {
    required this.index,
    required super.offset,
    required super.limit,
    super.hasLoadMore = true,
    super.timespan,
    super.cursor,
  });

  @override
  List<Object?> get props =>
      [data, offset, limit, hasLoadMore, timespan, cursor];
}

class PullToRefreshSuccess<T, P2, P3>
    extends GetListDataPagingSuccess<T, P2, P3> {
  PullToRefreshSuccess(
    super.data, {
    super.timespan,
    required super.offset,
    required super.limit,
    super.hasLoadMore = true,
    super.cursor,
  });

  @override
  List<Object?> get props =>
      [data, offset, limit, hasLoadMore, timespan, cursor];
}

class GetListDataPagingFailed<T> extends GetListDataPagingSuccess {
  final String message;
  final dynamic error;

  GetListDataPagingFailed(
    this.message,
    this.error,
    super.data, {
    super.timespan,
    required super.offset,
    required super.limit,
    super.hasLoadMore = true,
    super.cursor,
  });

  @override
  List<Object?> get props =>
      [message, error, data, offset, limit, hasLoadMore, timespan, cursor];
}

class GetListDataError<T> extends GetListState {
  final String message;
  final dynamic error;

  GetListDataError(this.message, this.error);

  @override
  List<Object?> get props => [message, error];
}
