// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class DeviceMediaLocalizations {
  DeviceMediaLocalizations();

  static DeviceMediaLocalizations? _current;

  static DeviceMediaLocalizations get current {
    assert(
      _current != null,
      'No instance of DeviceMediaLocalizations was loaded. Try to initialize the DeviceMediaLocalizations delegate before accessing DeviceMediaLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<DeviceMediaLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = DeviceMediaLocalizations();
      DeviceMediaLocalizations._current = instance;

      return instance;
    });
  }

  static DeviceMediaLocalizations of(BuildContext context) {
    final instance = DeviceMediaLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of DeviceMediaLocalizations present in the widget tree. Did you add DeviceMediaLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static DeviceMediaLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<DeviceMediaLocalizations>(
      context,
      DeviceMediaLocalizations,
    );
  }

  /// `Bold`
  String get bold {
    return Intl.message(
      'Bold',
      name: 'bold',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `--------`
  String get end {
    return Intl.message(
      '--------',
      name: 'end',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<DeviceMediaLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi', countryCode: 'VN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<DeviceMediaLocalizations> load(Locale locale) =>
      DeviceMediaLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
