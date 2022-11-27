import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:digdes_ui/ui/roots/loader.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Loader.create(),
      navigatorKey: AppNavigator.key,
      onGenerateRoute: (settings) =>
          AppNavigator.onGeneratedRoutes(settings, context),
    );
  }
}
