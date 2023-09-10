import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dark_mode_ui_state/device_setting_type.dart';
import 'viewmodel/dark_mode_viewmodel.dart';

class DarkModeSettingScreen extends StatefulWidget {
  static const String routeName = '/general-settings';

  const DarkModeSettingScreen({
    super.key,
    this.appName,
  });

  final String? appName;

  @override
  State<DarkModeSettingScreen> createState() => _DarkModeSettingScreenState();
}

class _DarkModeSettingScreenState extends State<DarkModeSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark mode'),
      ),
      body: Consumer<DarkModeSettingViewModel>(
        builder: (context, model, child) {
          final isDarkMode = model.selected == DeviceModeSettingsType.dark ||
              Theme.of(context).brightness == Brightness.dark;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 18),
                  child: Text(
                    '''Choose how your ${widget.appName} experience looks for this device.''',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ...DeviceModeSettingsType.values.map(
                  (e) => RadioListTile<DeviceModeSettingsType>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      e.title(context),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: model.selected,
                    groupValue: e,
                    onChanged: (DeviceModeSettingsType? value) {
                      model.onSelected(e);
                      switch (e) {
                        case DeviceModeSettingsType.dark:
                          AdaptiveTheme.of(context).setDark();
                          break;
                        case DeviceModeSettingsType.light:
                          AdaptiveTheme.of(context).setLight();
                          break;
                        case DeviceModeSettingsType.deviceSetting:
                          AdaptiveTheme.of(context).setSystem();
                          break;
                        default:
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 20),
                  child: Text(
                    '''If you choose Device settings, this app will use the mode that's already selected in the devices's settings ''',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isDarkMode ? Colors.white : Colors.grey[900],
                        ),
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
