extension StringExt on String {
  bool get isExternalInport => startsWith('import \'package');

  bool get isDartInport => startsWith('import \'dart');

  bool get isExport => startsWith('export');
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T it) op) => op(this);
}
