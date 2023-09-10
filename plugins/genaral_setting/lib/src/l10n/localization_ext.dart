import 'package:flutter/widgets.dart';

import 'generated/genaral_setting_localizations.dart';
import 'generated/genaral_setting_localizations_vi.dart';

export 'generated/genaral_setting_localizations.dart';

extension GenaralSettingLocalizationOnContextExt on BuildContext {
  GenaralSettingLocalizations get genaralSettingl10n =>
      GenaralSettingLocalizations.of(this) ?? GenaralSettingLocalizationsVi();
}

extension GenaralSettingLocalizationsLocalizationOnStateExt on State {
  GenaralSettingLocalizations get ecomL10n => context.genaralSettingl10n;
}
