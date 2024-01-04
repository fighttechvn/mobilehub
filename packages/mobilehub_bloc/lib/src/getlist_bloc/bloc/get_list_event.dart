part of 'get_list_bloc.dart';

@immutable
abstract class GetListEvent {}

class GetListDataEvent extends GetListEvent {}

class GetListDataTypeSearchText<T> extends GetListEvent {
  final bool Function(dynamic element) where;
  final String textSearch;

  GetListDataTypeSearchText(
    this.where, {
    required this.textSearch,
  });
}

class GetListDataParam1Event extends GetListEvent {
  final dynamic param1;

  GetListDataParam1Event(this.param1);
}

class GetListDataParam2Event extends GetListEvent {
  final dynamic param1;
  final dynamic param2;
  final bool fetchNewData;

  GetListDataParam2Event(
    this.param1,
    this.param2, {
    this.fetchNewData = true,
  });
}

class GetListDataParam3Event extends GetListEvent {
  final dynamic param1;
  final dynamic param2;
  final dynamic param3;

  GetListDataParam3Event(this.param1, this.param2, this.param3);
}

class RemoveItemFromListEvent<T> extends GetListEvent {
  final bool Function(dynamic element) where;

  RemoveItemFromListEvent(this.where);
}

class AddItemIntoListEvent<T> extends GetListEvent {
  final T item;

  AddItemIntoListEvent(this.item);
}

class RemoveItemEvent<T> extends GetListEvent {
  final T item;

  RemoveItemEvent(this.item);
}

class AddItemEvent<P> extends GetListEvent {
  final P param;

  AddItemEvent(this.param);
}

class AddItemToListEvent<T> extends GetListEvent {
  final T item;
  final int index;

  AddItemToListEvent(this.item, [this.index = 0]);
}

class UpdateItemToListEvent<T> extends GetListEvent {
  final T item;
  final bool Function(T element) where;

  UpdateItemToListEvent(this.item, this.where);
}

class UpdateDataListEvent<T> extends GetListEvent {
  final List<T> Function(List<T> element) onUpdate;

  UpdateDataListEvent(this.onUpdate);
}

enum TypeFetchPaging { fetch, refresh, renew }

class GetListPagingEvent<P1, P2, P3> extends GetListEvent {
  final P1 param1;
  final P2 offset;
  final P3 limit;
  final TypeFetchPaging type;

  GetListPagingEvent(
    this.param1, {
    required this.offset,
    required this.limit,
    required this.type,
  });
}

class LoadDataListEvent<T, P1, P2, P3> extends GetListEvent {
  final P1 param1;
  final P2 offset;
  final P3 limit;
  final List<T> listData;
  final TypeFetchPaging type;

  LoadDataListEvent(
    this.param1, {
    required this.listData,
    required this.offset,
    required this.limit,
    required this.type,
  });
}
