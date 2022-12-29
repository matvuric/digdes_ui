import 'dart:io';

import 'package:digdes_ui/data/clients/api_client.dart';
import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_profile.dart';
import 'package:digdes_ui/domain/models/create_post.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/push_token.dart';
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
  Future createProfile({required CreateProfile model}) async =>
      await _auth.createProfile(model);

  @override
  Future editProfile({required EditProfile model}) async =>
      await _api.editProfile(model);

  @override
  Future<User?> getUser() async => await _api.getUser();

  @override
  Future<List<PostModel>> getPosts(int skip, int take) async =>
      await _api.getPosts(skip, take);

  @override
  Future<List<AttachmentMeta>> uploadTemp({required List<File> files}) async =>
      await _api.uploadTemp(files: files);

  @override
  Future setAvatar(AttachmentMeta model) async => await _api.setAvatar(model);

  @override
  Future createPost(CreatePost model) async => await _api.createPost(model);

  @override
  Future subscribe(PushToken model) async => await _api.subscribe(model);

  @override
  Future unsubscribe() async => await _api.unsubscribe();
}
