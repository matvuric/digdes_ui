import 'package:digdes_ui/data/services/data_service.dart';
import 'package:digdes_ui/data/services/sync_service.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/ui/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppViewModel extends ChangeNotifier {
  final _dataService = DataService();
  final listViewController = ScrollController();
  BuildContext context;
  AppViewModel({required this.context}) {
    asyncInit();
    listViewController.addListener(() {
      var max = listViewController.position.maxScrollExtent;
      var current = listViewController.offset;
      var percent = current / max * 100;
      if (percent > 80) {
        if (!isLoading) {
          isLoading = true;
          Future.delayed(const Duration(seconds: 1)).then((value) {
            posts = <PostModel>[...posts!, ...posts!];
            isLoading = false;
          });
        }
      }
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
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

  Map<int, int> pager = <int, int>{};

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();

    if (user!.avatarLink != null) {
      var img =
          await NetworkAssetBundle(Uri.parse("$baseUrl2${user!.avatarLink}"))
              .load("$baseUrl2${user!.avatarLink}");
      avatar = Image.memory(img.buffer.asUint8List());
    }

    await SyncService().syncPosts();
    posts = await _dataService.getPosts();
  }

  void onPageChanged(int listIndex, int pageIndex) {
    pager[listIndex] = pageIndex;
    notifyListeners();
  }

  void goUp() {
    listViewController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void toProfile(BuildContext bc) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (__) => Profile.create(bc)));
  }
}
