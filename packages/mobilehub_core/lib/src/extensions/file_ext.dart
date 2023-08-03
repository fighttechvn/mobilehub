import 'dart:io';
import 'dart:math';
// import 'dart:ui';
// import 'package:image/image.dart' as img;

extension FileExt on File {
  // Future<Size?> getSizeFileImage() async {
  //   final bytes = await readAsBytes();
  //   final img.Image? src = img.decodeImage(bytes);

  //   if (src == null) {
  //     return null;
  //   }

  //   return Size(src.width.toDouble(), src.height.toDouble());
  // }
}

extension FileSizeTextExt on int {
  String sizeText({int decimals = 2}) {
    final bytes = this;
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
