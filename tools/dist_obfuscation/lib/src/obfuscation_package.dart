import 'dart:async';
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'common/file_helper.dart';
import 'common/utils.dart';
import 'common/yaml_extension.dart';
import 'model/config.dart';
import 'model/file.dart';

Future<void> obfuscationPackage({required List<String> args}) async {
  final packageName = await getPackageName();
  final config = await loadConfig();

  final packageDir = Directory('lib/src');
  if (!packageDir.existsSync()) {
    throw ArgumentError('Package $packageName not found.');
  }

  const obfuscatedFolder = 'dist';
  const obfuscatedPath = './$obfuscatedFolder';
  final obfuscatedFileName = '$packageName.dart';

  // Create the merged file
  final obfuscatedFile = await FilesHelper.createFile(
    '$obfuscatedPath/$obfuscatedFileName',
  );

  // Collect all the import and part statements from the files
  var content = await readDartFileInDir(config, packageDir.path, packageName);

  // apply config
  for (final entry in config.ignoresToClone) {
    final clonePath = entry.path.replaceFirst(
      'lib/src/',
      'lib/$obfuscatedFolder/',
    );
    if (await isDir(entry.path)) {
      await copyDirectory(
        entry.path,
        clonePath,
      );
    } else {
      await copyFile(
        entry.path,
        clonePath,
      );
    }

    final pathToImport = 'import \'${entry.pathToImport.replaceFirst(
      'lib/src/',
      '',
    )}\';';

    content = content.append(
      DartFileElement(
        imports: [
          pathToImport,
          pathToImport.replaceFirst('import', 'export'),
        ],
      ),
    );
  }

  await obfuscatedFile.writeAsString(
    '''library $packageName;

${content.fileContent}''',
    mode: FileMode.write,
  );
}

Future<String> getPackageName() async {
  final dir = Directory('./');
  final yamlFile = File('${dir.path}/pubspec.yaml');
  final pubspecYaml = loadYaml(await yamlFile.readAsString()) as Map;
  return pubspecYaml['name'].toString();
}

Future<DartFileElement> getFileElement(File file, String packageName) async {
  final lines = await file.readAsLines();
  final ignoreFile = <String>[];
  final imports = <String>[];
  var body = '';

  for (final line in lines) {
    if (line.isEmpty) {
      continue;
    }
    if (line.startsWith('// ignore_for_file:')) {
      ignoreFile.add(line);
    } else if (line.startsWith('import')) {
      if (line.isExternalInport || line.isDartInport) {
        imports.add(line);
      }
    } else if (!line.startsWith('part')) {
      body += '$line\n';
    }
  }

  // remove all as import
  // from: import 'package:dist_obfuscation/lib/obfuscation_package.dart' as _i4;
  // to: import 'package:dist_obfuscation/lib/obfuscation_package.dart';
  final regex = RegExp(r'as\s+(?<name>\w+);');
  for (final import in [...imports]) {
    final match = regex.firstMatch(import);

    if (match != null && match.namedGroup('name') != null) {
      final variableName = match.namedGroup('name');
      body = body.replaceAll('$variableName.', '');
      if (import.contains('package:$packageName')) {
        imports.remove(import);
      } else {
        final idx = imports.indexOf(import);
        imports[idx] = import.replaceAll(' ${match.group(0)}', ';');
      }
    }
  }

  return DartFileElement(ignoreFile: ignoreFile, imports: imports, body: body);
}

Future<DartFileElement> readDartFileInDir(
  ObfuscationConfig config,
  String directory,
  String packageName,
) async {
  var content = DartFileElement();
  final dir = Directory(directory);

  final entities = await dir.list().toList();
  for (final e in entities) {
    if (config.ignoresToClone.any((i) => e.path.contains(i.path))) {
      continue;
    }

    if (e is File) {
      if (!e.path.contains('.dart')) {
        continue;
      }

      content = content.append(await getFileElement(e, packageName));
    } else if (e is Directory) {
      content = content.append(
        await readDartFileInDir(config, e.path, packageName),
      );
    }
  }

  return content;
}

Future<ObfuscationConfig> loadConfig() async {
  const filePath = 'dist_obfuscation.yaml';
  if (!File(filePath).existsSync()) {
    return const ObfuscationConfig();
  } else {
    final yamlMap = loadYaml(File(filePath).readAsStringSync()) as YamlMap;
    return ObfuscationConfig.fromJson(yamlMap.recursiveCast());
  }
}
