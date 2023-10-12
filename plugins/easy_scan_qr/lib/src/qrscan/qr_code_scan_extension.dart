import 'package:flutter/material.dart';

import 'widgets/qr_code_scan_widget.dart';

extension BuildContextExtQrCode<T> on BuildContext {
  Future<T?> startQRCodeScan() {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => const QrCodeScanWidget()),
    );
  }
}
