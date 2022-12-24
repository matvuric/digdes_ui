import 'package:digdes_ui/domain/enums/tab_item.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppViewModel extends ChangeNotifier {
  BuildContext context;
  AppViewModel({required this.context}) {
    asyncInit();
  }

  final navigationKeys = {
    TabItemEnum.home: GlobalKey<NavigatorState>(),
    TabItemEnum.search: GlobalKey<NavigatorState>(),
    TabItemEnum.newPost: GlobalKey<NavigatorState>(),
    TabItemEnum.favs: GlobalKey<NavigatorState>(),
    TabItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  var _currentTab = TabEnums.defTab;
  TabItemEnum? beforeTab;
  TabItemEnum get currentTab => _currentTab;

  void selectTab(TabItemEnum item) {
    if (item == _currentTab) {
      navigationKeys[item]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      beforeTab = _currentTab;
      _currentTab = item;
      notifyListeners();
    }
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

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();

    if (user!.avatarLink != null) {
      var img =
          await NetworkAssetBundle(Uri.parse("$baseUrl2${user!.avatarLink}"))
              .load("$baseUrl2${user!.avatarLink}");
      avatar = Image.memory(img.buffer.asUint8List());
    }
  }
}
