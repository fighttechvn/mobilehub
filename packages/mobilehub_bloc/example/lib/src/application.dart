import 'package:example/src/routes.dart';
import 'package:flutter/material.dart';

import 'features/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      onGenerateRoute: Routes.generateRoute,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
