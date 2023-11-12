import 'package:flutter/widgets.dart';

import 'generated/sub_localizations.dart';
import 'generated/sub_localizations_vi.dart';

export 'generated/sub_localizations.dart';

extension SubLocalizationOnContextExt on BuildContext {
  SubLocalizations get subL10n =>
      SubLocalizations.of(this) ?? SubLocalizationsVi();
}

extension SubLocalizationsLocalizationOnStateExt on State {
  SubLocalizations get subL10n => context.subL10n;
}
