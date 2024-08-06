// import 'package:flutter/widgets.dart';

///
/// Step 1: with statefull
///        `with SaveWidgetToPictureMixin`
///
/// Step 2: wrap widget:
///     ` wrapWidgetSavePicture(
///           child: MyQRCodeWidget(
///
/// Step 3: use expose method save:
///     ``onSavePicture`
///
// mixin SaveWidgetToPictureMixin<T extends StatefulWidget> on State<T> {
//   final globalKey = GlobalKey<State<StatefulWidget>>();

//   void onSavePicture() {
//     context.showLoading();
//     globalKey.saveImage().then((value) {
//       context.hideLoading();
//     }).catchError((_) {
//       context.hideLoading();
//     });
//   }

//   Widget wrapWidgetSavePicture({required Widget child}) {
//     return RepaintBoundary(
//       key: globalKey,
//       child: child,
//     );
//   }
// }
