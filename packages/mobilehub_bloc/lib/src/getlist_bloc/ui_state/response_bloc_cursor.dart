class ReponseDataBlocCursor<T> {
  final List<T> listData;
  final dynamic cursor;

  ReponseDataBlocCursor(this.listData, this.cursor);
}

typedef LoadListFutureParam4<T, P> = Future<ReponseDataBlocCursor<T>> Function(
  P param,
  dynamic cursor,
);

Future<List<T>> emptyUsecase<T, P>(
  P param1,
  int param2,
  int param3,
) {
  return Future.value(<T>[]);
}
