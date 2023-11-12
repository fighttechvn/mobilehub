# Genaral Setting Easy features

#Setup
## 1: Init get saved theme
`final themeSaved = await initAdaptiveTheme();`

## 2: Add dependency injection
```
externalPackageModulesAfter: [
    ExternalModule(GenaralSettingPackageModule),
]
```

## 3: Add widget `MaterialApp`

Setup MaterialApp wrap by `AdaptiveThemeWidget` and add to delegate `GenaralSettingLocalizations.delegate`

```
  AdaptiveThemeWidget(
    lightTheme: ThemeData(primaryColor: Colors.amber),
    darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black12),
    builder: (context, ThemeData theme, ThemeData darkTheme) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        onGenerateRoute: Routes.generateRoute,
        home: const MyHomePage(title: 'Flutter Nice'),
        localizationsDelegates: const [
          GenaralSettingLocalizations.delegate,
        ],
      );
  });
```