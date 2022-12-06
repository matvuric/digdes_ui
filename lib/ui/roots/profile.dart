import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _authService = AuthService();
  _ViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Map<String, String>? headers;

  void asyncInit() async {
    var token = TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();
  }

  void _logOut() async {
    await _authService.logOut().then((value) => AppNavigator.toLoader());
  }

  void _refresh() async {
    await _authService.tryGetUser();
  }

  void _toEditor() {
    AppNavigator.toProfileEditor();
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    ImageProvider img;
    var screenSize = MediaQuery.of(context).size;

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
          title: Text(
            viewModel.user == null ? "Hi" : viewModel.user!.username,
          ),
          actions: [
            IconButton(
              onPressed: viewModel._toEditor,
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: viewModel._refresh,
              icon: const Icon(Icons.refresh_outlined),
            ),
            IconButton(
              onPressed: viewModel._logOut,
              icon: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
        body: (viewModel.user != null)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Material(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () {},
                              child: Ink.image(
                                image: img,
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: screenSize.width * 0.25,
                                  height: 100,
                                  child: Center(
                                      child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "${viewModel.user!.postsCount}\n",
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        const TextSpan(
                                            text: "Posts",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )))),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: screenSize.width * 0.25,
                                  height: 100,
                                  child: Center(
                                      child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "${viewModel.user!.followersCount}\n",
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        const TextSpan(
                                            text: "Followers",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )))),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                                // TODO : followers page / following page
                                width: screenSize.width * 0.25,
                                height: 100,
                                child: Center(
                                    child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              "${viewModel.user!.followingsCount}\n",
                                          style: const TextStyle(fontSize: 20)),
                                      const TextSpan(
                                          text: "Following",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ))),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text.rich(TextSpan(
                            text: viewModel.user!.bio,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                      ),
                    ]))
            : null);
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => _ViewModel(context: context),
        child: const Profile());
  }
}
