import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/ui/widgets/roots/app_vm.dart';
import 'package:digdes_ui/ui/navigation/app_navigator.dart';
import 'package:digdes_ui/ui/widgets/tab_profile/profile_editor/profile_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authService = AuthService();
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

  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? value) {
    _avatar = value;
    notifyListeners();
  }

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    if (user!.avatarLink != null && user != null) {
      var img =
          await NetworkAssetBundle(Uri.parse('$baseUrl2${user!.avatarLink}'))
              .load('$baseUrl2${user!.avatarLink}');
      avatar = Image.memory(img.buffer.asUint8List());

      // avatar = Image.network('$baseUrl2${user!.avatarLink}');
    }
  }

  void logOut() async {
    await _authService.logOut().then((value) => AppNavigator.toLoader());
  }

  void toEditor(BuildContext bc) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (__) => ProfileEditor.create(bc)));
  }

  void addAvatar(Image avatar) {
    var appModel = context.read<AppViewModel>();
    appModel.avatar = avatar;
  }
}
