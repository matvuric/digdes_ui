import 'package:digdes_ui/ui/widgets/roots/app.dart';
import 'package:digdes_ui/ui/widgets/roots/auth.dart';
import 'package:digdes_ui/ui/widgets/roots/loader.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loader = "/";
  static const auth = "/auth";
  static const app = "/app";
}

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

  static Future toLoader() async {
    return await key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loader, (((route) => false)));
  }

  static Future toAuth() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, (((route) => false)));
  }

  static Future toHome() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.app, (((route) => false)));
  }

  static Route<dynamic>? onGeneratedRoutes(
      RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case NavigationRoutes.loader:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => Loader.create()));

      case NavigationRoutes.auth:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => Auth.create()));

      case NavigationRoutes.app:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => App.create()));
    }
    return null;
  }
}
