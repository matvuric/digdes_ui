import 'package:digdes_ui/data/services/data_service.dart';
import 'package:digdes_ui/data/services/sync_service.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/ui/navigation/app_navigator.dart';
import 'package:digdes_ui/ui/navigation/tab_navigator.dart';
import 'package:digdes_ui/ui/widgets/tab_profile/profile.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final _dataService = DataService();
  final listViewController = ScrollController();
  BuildContext context;
  HomeViewModel({required this.context}) {
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

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Map<int, int> pager = <int, int>{};

  Future asyncInit() async {
    await SyncService().syncPosts();
    posts = await _dataService.getPosts();
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
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
        .push(MaterialPageRoute(builder: (__) => Profile.create()));
  }

  void toPostDetails(String id) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: id);
  }

  void toPostCreator() {
    AppNavigator.toPostCreator().then((value) => asyncInit());
  }
}
