import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

typedef ReplayCountDown = bool Function();

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({
    super.key,
    this.onFinish,
    required this.builder,
    required this.time,
    this.controller,
    this.autoRun = true,
  });

  final Widget Function(Duration time, bool canResend, ReplayCountDown onReplay)
      builder;

  /// Second
  final int time;
  final void Function()? onFinish;
  final CountDownController? controller;
  final bool autoRun;

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late final _controller = widget.controller ?? CountDownController();
  Timer? _timer;

  void _listenerController() {
    if (_controller._isRun && _timer == null) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (timer.tick <= widget.time) {
            final time = widget.time - timer.tick;
            _controller.updateTime(time);
          } else {
            _controller.stop();
            _timer?.cancel();
            _timer = null;
            widget.onFinish?.call();
          }
        },
      );
    }
  }

  void _onReplay() {
    _timer?.cancel();
    _timer = null;
    _controller.run();
  }

  @override
  void initState() {
    super.initState();
    _controller
      .._init(widget.time)
      ..addListener(_listenerController);
    if (widget.autoRun) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          _controller.run();
        },
      );
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listenerController)
      ..stop()
      ..dispose();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return widget.builder(
          Duration(seconds: _controller._time),
          _controller.isRunning == false,
          () {
            if (_controller._isRun == false) {
              _onReplay();
              return true;
            }

            return false;
          },
        );
      },
    );
  }
}

class CountDownController extends ChangeNotifier {
  bool _isRun = false;
  bool get isRunning => _isRun;
  int _time = 0;
  int _timeCountDown = 0;

  int get time => _time;

  void _init(int t) {
    _timeCountDown = t;
    _time = t;
    log('[CountDownController] init time');
  }

  void updateTime(int time) {
    if (_isRun) {
      _time = time > 0 ? time : 0;
      notifyListeners();
    }
  }

  void run() {
    if (_isRun == false) {
      _time = _timeCountDown;
      _isRun = true;
      notifyListeners();
    }
  }

  void stop() {
    if (_isRun) {
      _isRun = false;
      notifyListeners();
    }
  }
}
