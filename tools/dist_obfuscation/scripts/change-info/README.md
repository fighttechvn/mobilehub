## Change for Android
- android/app/build.gradle
- android/app/src/debug/AndroidManifest.xml
- android/app/src/main/AndroidManifest.xml
- android/app/src/main/kotlin/vn/fighttech/aimii/MainActivity.kt
- android/app/src/profile/AndroidManifest.xml

## Change for iOS
- ios/Runner/Info.plist
- ios/Runner.xcodeproj/project.pbxproj

## Change for MacOS (chưa xử lý)
- macos/Runner.xcodeproj/project.pbxproj
- macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
- macos/Runner/Configs/Appinfo.xcconfig

## Change for Project(Dart)

### Root
- pubspec.yaml
- README.md

### App Main (module: app_main)
- modules/app_main/lib/src/app_delegate.dart
- modules/app_main/lib/src/presentation/dashboard/account/views/account_screen.dart
- modules/app_main/lib/src/presentation/onboarding/enter_name/enter_name_screen.dart
- modules/app_main/lib/src/presentation/onboarding/enter_phonenumber/enter_phonenumber_screen.dart

### Localization
- modules/localization/lib/generated/10n.dart
- modules/localization/lib/generated/intl/messages_en.dart
- modules/localization/lib/generated/intl/messages_vi.dart
- modules/localization/lib/110n/intl_en.arb
- modules/localization/lib/110n/intl_vi.arb

### Storybook
- modules/storybook/.firebaserc
- modules/storybook/README.md
- modules/storybook/lib/main.dart

### Web
- web/index.html
- web/manifest.json
