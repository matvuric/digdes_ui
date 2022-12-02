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
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel.user == null ? "Hi" : viewModel.user!.username,
        ),
        actions: [
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
      body: Column(
        children: [
          if (viewModel.user != null && viewModel.headers != null)
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "$baseUrl2 ${viewModel.user!.avatarLink}",
                  headers: viewModel.headers),
              radius: 60,
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
