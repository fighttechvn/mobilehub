import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'impl/storage_service.impl.dart';

abstract class StorageService {
  Future<File> saveTempFile(Uint8List data, String fileName);

  Future<String> getFilePath(String assetPath,
      [String package = 'packages/design_system']);

  Future<ByteData> getFileData(String path);

  ///
  //  .getTemporaryDirectoryPath
  //  .then((tempDirPath) {
  //   final String fullPath = "$tempDirPath/journey.zip'";
  //   print('full path $fullPath');
  //   download2(dio, widget.fullUrl, fullPath);
  // });
  /// Ex: /Users/hieu.trantrung/Library/Developer/CoreSimulator/Devices/89112492-E84D-4875-9836-A64886FD398E/data/Containers/Data/Application/0D13CCF9-7D1B-4E4A-AAE4-8590906CDCD2/Library/Caches/journey.zip'
  ///
  Future<String> get getTemporaryDirectoryPath;

  Future<Directory> createDir(String folderName);
}

extension ObjStorageService on Object {
  StorageService get _storageService => StorageServiceImpl();

  Future<String> get getTemporaryDirectoryPath =>
      _storageService.getTemporaryDirectoryPath;

  Future<Directory> createDir(String folderName) =>
      _storageService.createDir(folderName);
}
