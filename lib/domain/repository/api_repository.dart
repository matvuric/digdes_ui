import 'dart:io';

import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_account.dart';
import 'package:digdes_ui/domain/models/create_post.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/models/user.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});

  Future<TokenResponse?> getRefreshToken({required String refreshToken});

  Future createAccount({required CreateAccount model});

  Future editProfile({required EditProfile model});

  Future<List<AttachmentMeta>> uploadTemp({required List<File> files});

  Future setAvatar(AttachmentMeta model);

  Future createPost(CreatePost model);

  Future<User?> getUser();

  Future<List<PostModel>> getPosts(int skip, int take);
}
