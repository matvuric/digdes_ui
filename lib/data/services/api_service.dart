import 'dart:io';

import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_post.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';

class ApiService {
  final _api = RepositoryModule.apiRepository();

  Future editProfile(EditProfile model) async {
    await _api.editProfile(model: model);
  }

  Future<List<AttachmentMeta>> uploadTemp(List<File> files) async {
    return await _api.uploadTemp(files: files);
  }

  Future setAvatar(AttachmentMeta model) async {
    await _api.setAvatar(model);
  }

  Future createPost(CreatePost model) async {
    await _api.createPost(model);
  }
}
