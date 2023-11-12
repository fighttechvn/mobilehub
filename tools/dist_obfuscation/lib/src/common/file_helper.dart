// ignore_for_file: cascade_invocations

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> copyDirectory(String sourcePath, String destinationPath) async {
  final sourceDirectory = Directory(sourcePath);
  final destinationDirectory = Directory(destinationPath);

  // Create destination directory if it doesn't already exist
  if (!destinationDirectory.existsSync()) {
    destinationDirectory.createSync(recursive: true);
  }

  // Copy each file in source directory to destination directory
  await for (final entity in sourceDirectory.list(recursive: true)) {
    if (entity is File) {
      final relativePath = p.relative(entity.path, from: sourceDirectory.path);
      final destinationFilePath = p.join(
        destinationDirectory.path,
        relativePath,
      );

      // Create intermediate directories if necessary
      final destinationFile = File(destinationFilePath);
      destinationFile.createSync(recursive: true);

      // Copy the file content
      await entity.copy(destinationFilePath);
    }
  }
}

Future<void> copyFile(String sourcePath, String destinationPath) async {
  final source = File(sourcePath);

  if (!source.existsSync()) {
    return;
  }

  final destination = await FilesHelper.createFile(destinationPath);

  // Copy the contents of the source file to the destination file
  source.copySync(destination.path);
}

Future<bool> isDir(String path) {
  return FileSystemEntity.type(path).then((type) {
    return type == FileSystemEntityType.directory;
  });
}

class FilesHelper {
  FilesHelper._();
  static Future<File> createFile(String path) async {
    final obfuscatedFile = File(path);

    if (await obfuscatedFile.exists()) {
      await obfuscatedFile.delete();
    }

    await obfuscatedFile.create(recursive: true);

    return obfuscatedFile;
  }

  static Future<bool> writeFile({
    required String pathFile,
    required String content,
  }) async {
    final file = await createFile(pathFile);

    await file.writeAsString(content);
    return file.path.isNotEmpty;
  }
}
