import 'dart:io';

import 'package:digdes_ui/data/clients/api_client.dart';
import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_account.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/refresh_token_request.dart';
import 'package:digdes_ui/domain/models/token_request.dart';
import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/domain/repository/api_repository.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;
  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken(
      {required String login, required String password}) async {
    return await _auth.getToken(TokenRequest(login: login, password: password));
  }

  @override
  Future<TokenResponse?> getRefreshToken({required String refreshToken}) async {
    return await _auth
        .getRefreshToken(RefreshTokenRequest(refreshToken: refreshToken));
  }

  @override
  Future createAccount({required CreateAccount model}) async =>
      await _auth.createAccount(model);

  @override
  Future editProfile(
          {String? username,
          String? firstName,
          String? lastName,
          String? bio,
          String? gender,
          String? phone,
          String? email,
          DateTime? birthDate,
          bool? isPrivate}) async =>
      await _api.editProfile(EditProfile(
          username: username,
          firstName: firstName,
          lastName: lastName,
          bio: bio,
          gender: gender,
          phone: phone,
          email: email,
          birthDate: birthDate,
          isPrivate: isPrivate));

  @override
  Future<User?> getUser() async => await _api.getUser();

  @override
  Future<List<PostModel>> getPosts(int skip, int take) async =>
      await _api.getPosts(skip, take);

  @override
  Future<List<AttachmentMeta>> uploadTemp({required List<File> files}) =>
      _api.uploadTemp(files: files);

  @override
  Future setAvatar(AttachmentMeta model) => _api.setAvatar(model);
}
