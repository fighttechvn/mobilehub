import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanWidget extends StatefulWidget {
  final Widget? description;

  const QrCodeScanWidget({super.key, this.description});

  @override
  State<QrCodeScanWidget> createState() => _QrCodeScanWidgetState();
}

class _QrCodeScanWidgetState extends State<QrCodeScanWidget> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var _isDone = false;

  // In order to get hot reload to work
  // we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (kReleaseMode) {
      return;
    }

    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    if (Platform.isAndroid) {
      // Android not open camera on first time.
      controller.resumeCamera();
    }
    controller.scannedDataStream.listen((scanData) {
      if (!_isDone) {
        _isDone = true;

        Navigator.of(context).pop(scanData.code);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                            left: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                            right: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                            left: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                            right: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 38.0, left: 16, right: 16),
                    child: widget.description ??
                        Text(
                          'Place QR code in the frame',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.all(16).copyWith(bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 160,
                    child: IconButton(
                      iconSize: 40,
                      onPressed: Navigator.of(context).pop,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
