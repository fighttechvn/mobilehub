import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

extension AleartDialogExt on BuildContext {
  Future<T?> startAlert<T>({
    String? title,
    String? content,
    String? text1,
    String? text2,
    dynamic Function(bool isYes)? popValue,
  }) async {
    return showDialog(
      context: this,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        if (UniversalPlatform.isAndroid) {
          return AlertDialog(
            title: title == null ? null : Text(title),
            content: content == null ? null : Text(content),
            actions: [
              TextButton(
                child: Text(
                  text1 ?? 'OK',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(popValue == null ? true : popValue(true));
                },
              ),
              TextButton(
                child: Text(
                  text2 ?? 'CANCEL',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pop(popValue == null ? false : popValue(false));
                },
              ),
            ],
          );
        }

        return CupertinoAlertDialog(
          title: title == null ? null : Text(title),
          content: content == null ? null : Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(text1 ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            CupertinoDialogAction(
              child: Text(text2 ?? 'CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
