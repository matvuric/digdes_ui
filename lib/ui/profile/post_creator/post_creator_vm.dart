import 'dart:io';

import 'package:digdes_ui/data/services/api_service.dart';
import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_post.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/ui/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostCreatorViewModel extends ChangeNotifier {
  final apiService = ApiService();
  final BuildContext context;
  PostCreatorViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  File? _img;
  File? get img => _img;
  set img(File? value) {
    _img = value;
    notifyListeners();
  }

  CreatePost? _post;
  CreatePost? get post => _post;
  set post(CreatePost? value) {
    _post = value;
    notifyListeners();
  }

  int pager = 1;
  List<File> imgList = [];
  List<AttachmentMeta> metaList = [];
  var caption = TextEditingController();

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();

    post =
        CreatePost(authorId: user!.id, caption: '', postAttachments: metaList);
  }

  Future pickImages() async {
    final pickedImgs = await ImagePicker().pickMultiImage();

    if (pickedImgs.isNotEmpty) {
      for (var img in pickedImgs) {
        imgList.add(File(img.path));
      }

      if (imgList.isNotEmpty) {
        metaList = await apiService.uploadTemp(imgList);
        img = imgList.first;
      }
    }
  }

  Future takePhoto() async {
    final takenPhoto =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (takenPhoto != null) {
      imgList.add(File(takenPhoto.path));
    }

    if (imgList.isNotEmpty) {
      metaList.add((await apiService.uploadTemp([imgList.last])).first);
      if (metaList.length < 2) {
        img = imgList.first;
      }
    }
  }

  void onPageChanged(int pageIndex) {
    pager = pageIndex;
    notifyListeners();
  }

  void confirm() async {
    post?.caption = caption.text;
    post?.postAttachments = metaList;
    await apiService.createPost(post!);
  }

  void addPost() {
    var profileModel = context.read<ProfileViewModel>();
    profileModel.addPost();
  }
}
