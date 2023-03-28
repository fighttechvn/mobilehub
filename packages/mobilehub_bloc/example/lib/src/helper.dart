extension IntExt on int {
  List<T> toListIndexObject<T>(T Function(int) newObj) {
    final result = <T>[];
    for (var i = 0; i < this; i++) {
      result.add(newObj(i));
    }
    return result;
  }
}
