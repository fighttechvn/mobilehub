import 'dart:developer';

import 'package:easy_loading_adaptive/easy_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:universal_platform/universal_platform.dart';

class InAppWebViewWidget extends StatefulWidget {
  const InAppWebViewWidget({
    Key? key,
    required this.url,
    this.onVerifySuccessed,
    this.onLoaded,
  }) : super(key: key);

  final String url;
  final void Function(bool)? onVerifySuccessed;
  final void Function()? onLoaded;

  @override
  State<InAppWebViewWidget> createState() => _InAppWebViewWidgetState();
}

class _InAppWebViewWidgetState extends State<InAppWebViewWidget> {
  bool isShowLoading = UniversalPlatform.isAndroid;
  InAppWebViewController? controller;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {}

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (UniversalPlatform.isAndroid) {
        initial();
      }
    });

    if (kDebugMode) {
      log('[InAppWebview] url: ${widget.url}');
    }
  }

  Future<void> initial() async {
    final swAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    if (swAvailable) {
      ServiceWorkerController.instance()
          .setServiceWorkerClient(ServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          if (kDebugMode) {
            print(request);
          }
          return null;
        },
      ));
      setState(() {
        isShowLoading = false;
      });
    }
  }

  @override
  void dispose() {
    InAppWebViewController.clearAllCache();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final htmlRaw = '''
<html>
<body>
  <iframe style="width:100%;height:100%;"
    src="https://docs.google.com/gview?url=${widget.url}&embedded=true" frameborder="0"></iframe>
</body>
</html>
''';

    return isShowLoading == true
        ? const LoadingWidget()
        : InAppWebView(
            initialSettings: InAppWebViewSettings(
              transparentBackground: true,
            ),
            // initialFile: _localFile?.path ?? _localPath,
            initialData: UniversalPlatform.isAndroid == false
                ? null
                : InAppWebViewInitialData(data: htmlRaw),

            initialUrlRequest: UniversalPlatform.isIOS == false
                ? null
                : URLRequest(url: WebUri(widget.url)),
            onReceivedError: (controller, request, error) {
              if (kDebugMode) {
                log('[Webview]'
                    'url: $request'
                    'code: $controller'
                    'error: $error'
                    '');
              }
            },
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED);
            },
            onWebViewCreated: (InAppWebViewController controller) {
              controller = controller;
              widget.onLoaded?.call();
            },
            onLoadStop: (controller, url) {},
            onUpdateVisitedHistory: (controller, url, androidIsReload) {},
          );
  }
}
