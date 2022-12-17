import 'dart:io';

import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/models/user.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});

  Future<TokenResponse?> getRefreshToken({required String refreshToken});

  Future editProfile(
      {String? username,
      String? firstName,
      String? lastName,
      String? bio,
      String? gender,
      String? phone,
      String? email,
      DateTime? birthDate,
      bool? isPrivate});

  Future<List<AttachmentMeta>> uploadTemp({required List<File> files});

  Future setAvatar(AttachmentMeta model);

  Future<User?> getUser();

  Future<List<PostModel>> getPosts(int skip, int take);
}
