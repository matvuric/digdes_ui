import 'package:digdes_ui/ui/roots/app.dart';
import 'package:digdes_ui/ui/auth/auth.dart';
import 'package:digdes_ui/ui/roots/loader.dart';
import 'package:digdes_ui/ui/roots/profile_editor.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loader = "/";
  static const auth = "/auth";
  static const app = "/app";
  static const profile = "/app/profile";
  static const profileEditor = "/app/profile/editor";
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

  static Future toProfileEditor() async {
    return await key.currentState?.pushNamed(NavigationRoutes.profileEditor);
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

      case NavigationRoutes.profileEditor:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => ProfileEditor.create()));
    }
    return null;
  }
}
