// ignore_for_file: unused_import

import './platforms/platform_io.dart'
    if (dart.library.html) './platforms/web_io.dart'
    if (dart.library.io) './platforms/mobile_io.dart' show getFile;
