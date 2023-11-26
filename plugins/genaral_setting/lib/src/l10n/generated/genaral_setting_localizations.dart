import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'genaral_setting_localizations_en.dart';
import 'genaral_setting_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of GenaralSettingLocalizations
/// returned by `GenaralSettingLocalizations.of(context)`.
///
/// Applications need to include `GenaralSettingLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/genaral_setting_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: GenaralSettingLocalizations.localizationsDelegates,
///   supportedLocales: GenaralSettingLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the GenaralSettingLocalizations.supportedLocales
/// property.
abstract class GenaralSettingLocalizations {
  GenaralSettingLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static GenaralSettingLocalizations? of(BuildContext context) {
    return Localizations.of<GenaralSettingLocalizations>(
        context, GenaralSettingLocalizations);
  }

  static const LocalizationsDelegate<GenaralSettingLocalizations> delegate =
      _GenaralSettingLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @discountLable.
  ///
  /// In vi, this message translates to:
  /// **'Giảm 1'**
  String get discountLable;

  /// No description provided for @sold.
  ///
  /// In vi, this message translates to:
  /// **'đã bán'**
  String get sold;

  /// No description provided for @origin.
  ///
  /// In vi, this message translates to:
  /// **'Xuất xứ'**
  String get origin;

  /// No description provided for @size.
  ///
  /// In vi, this message translates to:
  /// **'Kích thước'**
  String get size;

  /// No description provided for @weight.
  ///
  /// In vi, this message translates to:
  /// **'Trọng lượng'**
  String get weight;

  /// No description provided for @state.
  ///
  /// In vi, this message translates to:
  /// **'Tình trạng'**
  String get state;

  /// No description provided for @warranty.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành'**
  String get warranty;

  /// No description provided for @description.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get description;

  /// No description provided for @parameters.
  ///
  /// In vi, this message translates to:
  /// **'Thông số'**
  String get parameters;

  /// No description provided for @newState.
  ///
  /// In vi, this message translates to:
  /// **'Mới'**
  String get newState;

  /// No description provided for @likeNew.
  ///
  /// In vi, this message translates to:
  /// **'99%'**
  String get likeNew;

  /// No description provided for @seeMore.
  ///
  /// In vi, this message translates to:
  /// **'Xem Thêm'**
  String get seeMore;

  /// No description provided for @seeLess.
  ///
  /// In vi, this message translates to:
  /// **'Thu Gọn'**
  String get seeLess;

  /// No description provided for @productEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không có sản phẩm nào'**
  String get productEmpty;

  /// No description provided for @search.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm'**
  String get search;

  /// No description provided for @viewReviewItem.
  ///
  /// In vi, this message translates to:
  /// **'Xem đánh giá'**
  String get viewReviewItem;

  /// No description provided for @productReview.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá sản phẩm'**
  String get productReview;

  /// No description provided for @seeAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get seeAll;
}

class _GenaralSettingLocalizationsDelegate
    extends LocalizationsDelegate<GenaralSettingLocalizations> {
  const _GenaralSettingLocalizationsDelegate();

  @override
  Future<GenaralSettingLocalizations> load(Locale locale) {
    return SynchronousFuture<GenaralSettingLocalizations>(
        lookupGenaralSettingLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_GenaralSettingLocalizationsDelegate old) => false;
}

GenaralSettingLocalizations lookupGenaralSettingLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return GenaralSettingLocalizationsEn();
    case 'vi':
      return GenaralSettingLocalizationsVi();
  }

  throw FlutterError(
      'GenaralSettingLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
