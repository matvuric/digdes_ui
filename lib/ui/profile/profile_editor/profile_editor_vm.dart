import 'dart:io';

import 'package:digdes_ui/data/services/api_service.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/ui/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEditorViewModel extends ChangeNotifier {
  final apiService = ApiService();
  BuildContext context;
  ProfileEditorViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  File? _img;

  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? value) {
    _avatar = value;
    notifyListeners();
  }

  EditProfile? _profile;
  EditProfile? get profile => _profile;
  set profile(EditProfile? value) {
    _profile = value;
    notifyListeners();
  }

  var username = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();

    if (user!.avatarLink != null) {
      var img =
          await NetworkAssetBundle(Uri.parse("$baseUrl2${user!.avatarLink}"))
              .load("$baseUrl2${user!.avatarLink}");
      avatar = Image.memory(img.buffer.asUint8List());
    }

    username.text = user!.username;
    firstName.text = user!.firstName!;
    lastName.text = user!.lastName!;
    bio.text = user!.bio!;
    phone.text = user!.phone!;
    email.text = user!.email!;

    profile = EditProfile(
      username: user!.username,
      firstName: user!.firstName,
      lastName: user!.lastName,
      bio: user!.bio,
      gender: user!.gender,
      phone: user!.phone,
      email: user!.email,
      birthDate: user!.birthDate,
      isPrivate: user!.isPrivate,
    );
  }

  Future pickImage(ImageSource source) async {
    var profileModel = context.read<ProfileViewModel>();
    final pickedImg = await ImagePicker().pickImage(source: source);

    if (pickedImg != null) {
      final imgTemp = File(pickedImg.path);
      _img = imgTemp;

      if (_img != null) {
        var t = await apiService.uploadTemp([_img!]);

        if (t.isNotEmpty) {
          await apiService.setAvatar(t.first);
          var img = await NetworkAssetBundle(
                  Uri.parse("$baseUrl2${user!.avatarLink}"))
              .load("$baseUrl2${user!.avatarLink}");
          var avImage = Image.memory(img.buffer.asUint8List());
          avatar = avImage;
          profileModel.avatar = avImage;
          profileModel.addAvatar(avImage);
        }
      }
    }
  }

  void confirm() async {
    profile?.username = username.text;
    profile?.firstName = firstName.text;
    profile?.lastName = lastName.text;
    profile?.bio = bio.text;
    profile?.phone = phone.text;
    profile?.email = email.text;

    await apiService.editProfile(profile!);
  }
}
