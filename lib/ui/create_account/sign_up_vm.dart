import 'dart:io';

import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_account.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';
import 'package:digdes_ui/ui/auth/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SignUpViewModel extends ChangeNotifier {
  BuildContext context;
  final authService = AuthService();
  final _api = RepositoryModule.apiRepository();

  File? _img;
  File? get img => _img;
  set img(File? value) {
    _img = value;
    notifyListeners();
  }

  var _state = ViewModelState();
  ViewModelState get state => _state;
  set state(ViewModelState val) {
    _state = val;
    notifyListeners();
  }

  SignUpViewModel({required this.context}) {
    asyncInit();
  }

  CreateAccount? _user;
  CreateAccount? get user => _user;
  set user(CreateAccount? value) {
    _user = value;
    notifyListeners();
  }

  var username = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var retryPassword = TextEditingController();

  Map<String, String>? headers;

  void asyncInit() async {
    user = CreateAccount(
      username: '',
      firstName: '',
      lastName: '',
      bio: '',
      gender: '',
      password: '',
      phone: '',
      birthDate: DateTime.now(),
      email: '',
      isPrivate: false,
      retryPassword: '',
      image: AttachmentMeta(
        mimeType: '',
        name: '',
        size: 0,
        tempId: '',
      ),
    );
  }

  void confirm() async {
    user?.username = username.text;
    user?.firstName = firstName.text;
    user?.lastName = lastName.text;
    user?.bio = bio.text;
    user?.password = password.text;
    user?.phone = phone.text;
    user?.email = email.text;
    user?.retryPassword = retryPassword.text;

    await authService.createAccount(user!);
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedImg = await ImagePicker().pickImage(source: source);

      if (pickedImg != null) {
        final imgTemp = File(pickedImg.path);
        img = imgTemp;

        if (img != null) {
          var t = await _api.uploadTemp(files: [img!]);

          if (t.isNotEmpty) {
            user?.image = t.first;
          }
        }
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
