import 'package:flutter/widgets.dart';

import 'generated/example_localizations.dart';
import 'generated/example_localizations_vi.dart';

export 'generated/example_localizations.dart';

extension ExampleLocalizationOnContextExt on BuildContext {
  ExampleLocalizations get exampleL10n =>
      ExampleLocalizations.of(this) ?? ExampleLocalizationsVi();
}

extension ExampleLocalizationsLocalizationOnStateExt on State {
  ExampleLocalizations get exampleL10n => context.exampleL10n;
}
