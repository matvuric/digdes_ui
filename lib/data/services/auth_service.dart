import 'dart:io';

import 'package:digdes_ui/data/services/data_service.dart';
import 'package:digdes_ui/domain/models/create_profile.dart';
import 'package:digdes_ui/domain/models/push_token.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final _api = RepositoryModule.apiRepository();
  final _dataService = DataService();

  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      try {
        var token = await _api.getToken(login: login, password: password);

        if (token != null) {
          await TokenStorage.setStoredToken(token);
          var user = await _api.getUser();
          if (user != null) {
            SharedPrefs.setStoredUser(user);
          }
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkException();
        } else if (<int>[401].contains(e.response?.statusCode)) {
          throw WrongCredentialsException();
        } else if (<int>[500].contains(e.response?.statusCode)) {
          throw ServerException();
        }
      }
    }
  }

  Future<bool> checkAuth() async {
    var res = false;

    if (await TokenStorage.getAccessToken() != null) {
      var user = await _api.getUser();
      var token = await FirebaseMessaging.instance.getToken();

      if (user != null) {
        if (token != null) {
          await _api.subscribe(PushToken(token: token));
        }

        await SharedPrefs.setStoredUser(user);
        await _dataService.createUpdateUser(user);
      }

      res = true;
    }

    return res;
  }

  Future cleanToken() async {
    await TokenStorage.setStoredToken(null);
  }

  Future logOut() async {
    await _api.unsubscribe();

    await cleanToken();
  }

  Future createProfile(CreateProfile model) async =>
      await _api.createProfile(model: model);
}

class NoNetworkException implements Exception {}

class WrongCredentialsException implements Exception {}

class ServerException implements Exception {}
