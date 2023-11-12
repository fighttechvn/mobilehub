import '../common/utils.dart';

class DartFileElement {
  final List<String> ignoreFile;
  final List<String> imports;
  final String body;

  DartFileElement({
    this.ignoreFile = const [],
    this.imports = const [],
    this.body = '',
  });

  DartFileElement append(DartFileElement file) {
    return DartFileElement(
      ignoreFile: [...ignoreFile, ...file.ignoreFile],
      imports: [...imports, ...file.imports],
      body: '$body\n${file.body.trim()}',
    );
  }

  List<String> get ignoreFileSorted => ignoreFile.toSet().toList()..sort();

  List<String> get dartImport => [
        ...imports.toSet().toList().where((e) => e.isDartInport),
      ]..sort();

  List<String> get externalInport => [
        ...imports.toSet().toList().where((e) => e.isExternalInport),
      ]..sort();

  List<String> get projectImport => [
        ...imports.toSet().toList().where(
              (e) => !e.isDartInport && !e.isExternalInport && !e.isExport,
            ),
      ]..sort();

  List<String> get exports => [
        ...imports.toSet().toList().where((e) => e.isExport),
      ]..sort();

  String get fileHeader => [
        ignoreFileSorted.let((it) => it.isNotEmpty ? it.join('\n') : ''),
        dartImport.let((it) => it.isNotEmpty ? it.join('\n') : ''),
        externalInport.let((it) => it.isNotEmpty ? it.join('\n') : ''),
        projectImport.let((it) => it.isNotEmpty ? it.join('\n') : ''),
        exports.let((it) => it.isNotEmpty ? it.join('\n') : '')
      ].where((e) => e.isNotEmpty).join('\n\n');

  String get fileContent => '''$fileHeader

${body.trim()}
''';
}
