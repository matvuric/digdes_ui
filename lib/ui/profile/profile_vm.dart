import 'dart:io';

import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:digdes_ui/ui/roots/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authService = AuthService();
  // TODO : replace with service methods
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
    user = await SharedPrefs.getStoredUser();
    if (user!.avatarLink != null) {
      var img =
          await NetworkAssetBundle(Uri.parse("$baseUrl2${user!.avatarLink}"))
              .load("$baseUrl2${user!.avatarLink}");
      avatar = Image.memory(img.buffer.asUint8List());
    }
  }

  File? _img;

  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? value) {
    _avatar = value;
    notifyListeners();
  }

  Future pickImage(ImageSource source) async {
    try {
      var appModel = context.read<AppViewModel>();
      final pickedImg = await ImagePicker().pickImage(source: source);

      if (pickedImg != null) {
        final imgTemp = File(pickedImg.path);
        _img = imgTemp;

        if (_img != null) {
          var t = await _api.uploadTemp(files: [_img!]);

          if (t.isNotEmpty) {
            await _api.setAvatar(t.first);
            var img = await NetworkAssetBundle(
                    Uri.parse("$baseUrl2${user!.avatarLink}"))
                .load("$baseUrl2${user!.avatarLink}");
            var avImage = Image.memory(img.buffer.asUint8List());
            avatar = avImage;
            appModel.avatar = avImage;
          }
        }
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void logOut() async {
    await _authService.logOut().then((value) => AppNavigator.toLoader());
  }
}
