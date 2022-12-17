import 'dart:io';

import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';
import 'package:digdes_ui/ui/Common/camera_widget.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _api = RepositoryModule.apiRepository();
  final BuildContext context;
  ProfileViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Map<String, String>? headers;

  Future asyncInit() async {
    var token = TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();
  }

  String? _imagePath;
  String? get imagePath => _imagePath;
  set imagePath(String? value) {
    _imagePath = value;
    notifyListeners();
  }

  Future changeAvatar() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (newContext) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: CameraWidget(onFile: (file) {
            imagePath = file.path;
            Navigator.of(newContext).pop();
          }),
        ),
      );
    }));
    if (imagePath != null) {
      var t = await _api.uploadTemp(files: [File(imagePath!)]);
      if (t.isNotEmpty) {
        await _api.setAvatar(t.first);
      }
    }
  }

  void logOut() async {
    await _authService.logOut().then((value) => AppNavigator.toLoader());
  }
}
