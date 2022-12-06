import 'package:digdes_ui/data/services/auth_service.dart';
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

  void _refresh() async {
    await _authService.tryGetUser();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
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
              onTap: () {
                AppNavigator.toProfile();
              },
              child: Ink.image(
                image: img,
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          IconButton(
            onPressed: viewModel._refresh,
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => _ViewModel(context: context),
        child: const App());
  }
}
