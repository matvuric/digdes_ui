import 'package:digdes_ui/data/services/data_service.dart';
import 'package:digdes_ui/data/services/sync_service.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  // TODO : add localization
  BuildContext context;
  final _dataService = DataService();
  final _listViewController = ScrollController();

  _ViewModel({required this.context}) {
    asyncInit();
    _listViewController.addListener(() {
      var max = _listViewController.position.maxScrollExtent;
      var current = _listViewController.offset;
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

  Map<String, String>? headers;
  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Map<int, int> pager = <int, int>{};

  void onPageChanged(int listIndex, int pageIndex) {
    pager[listIndex] = pageIndex;
    notifyListeners();
  }

  void asyncInit() async {
    var token = TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();

    await SyncService().syncPosts();
    posts = await _dataService.getPosts();
  }

  void goUp() {
    _listViewController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var screenSize = MediaQuery.of(context).size;
    ImageProvider img;

    if (viewModel.user != null &&
        viewModel.headers != null &&
        viewModel.user!.avatarLink != null) {
      img = NetworkImage("$baseUrl2 ${viewModel.user!.avatarLink}",
          headers: viewModel.headers);
    } else {
      img = const AssetImage("assets/images/noavatar.png");
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("NastyGram"),
          actions: [
            Material(
              elevation: 8,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: AppNavigator.toProfile,
                child: Ink.image(
                  image: img,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.goUp,
          child: const Icon(Icons.arrow_upward_outlined),
        ),
        body: Container(
            child: viewModel.posts == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              controller: viewModel._listViewController,
                              itemBuilder: (listContext, listIndex) {
                                Widget res;
                                var posts = viewModel.posts;

                                if (posts != null) {
                                  var post = posts[listIndex];
                                  res = Container(
                                    height: screenSize.width,
                                    color: Colors.grey,
                                    child: Column(children: [
                                      Expanded(
                                        child: PageView.builder(
                                          itemBuilder:
                                              ((pageContext, pageIndex) =>
                                                  Container(
                                                    color: Colors.yellow,
                                                    child: Image(
                                                        image: NetworkImage(
                                                      "$baseUrl2 ${post.postAttachments[pageIndex].attachmentLink}",
                                                    )),
                                                  )),
                                          itemCount:
                                              post.postAttachments.length,
                                          onPageChanged: (value) => viewModel
                                              .onPageChanged(listIndex, value),
                                        ),
                                      ),
                                      PageIndicator(
                                        count: post.postAttachments.length,
                                        current: viewModel.pager[listIndex],
                                      ),
                                      Text(post.caption ?? "")
                                    ]),
                                  );
                                } else {
                                  res = const SizedBox.shrink();
                                }

                                return res;
                              },
                              separatorBuilder: ((context, index) =>
                                  const Divider()),
                              itemCount: viewModel.posts?.length ?? 0)),
                      if (viewModel.isLoading) const CircularProgressIndicator()
                    ],
                  )));
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => _ViewModel(context: context),
        child: const App());
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator(
      {Key? key, required this.count, required this.current, this.width = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    if (count > 1) {
      for (var i = 0; i < count; i++) {
        widgets.add(Icon(Icons.circle,
            size: width,
            color: i == (current ?? 0) ? Colors.blue : Colors.white));
      }
    }
    return Wrap(
      children: widgets,
    );
  }
}
