import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;
  _ViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  _ViewModelState copyWith({
    String? login,
    String? password,
    bool? isLoading = false,
    String? errorText,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  _ViewModel({required this.context}) {
    loginText.addListener(() {
      state = state.copyWith(login: loginText.text);
    });
    passwordText.addListener(() {
      state = state.copyWith(password: passwordText.text);
    });
  }

  var loginText = TextEditingController();
  var passwordText = TextEditingController();
  final _authService = AuthService();

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  set state(_ViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2))
        .then((value) => {state = state.copyWith(isLoading: false)});
    try {
      await _authService
          .auth(state.login, state.password)
          .then((value) => AppNavigator.toLoader());
    } on NoNetworkException {
      state = state.copyWith(errorText: "No Network");
    } on WrongCredentialsException {
      state = state.copyWith(errorText: "Incorrect login or password");
    }
  }
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextField(
                controller: viewModel.loginText,
                decoration: const InputDecoration(
                    hintText: "Enter Login",
                    icon: Icon(Icons.account_circle_outlined)),
              ),
              TextField(
                controller: viewModel.passwordText,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Enter Password", icon: Icon(Icons.key)),
              ),
              ElevatedButton(
                  onPressed: viewModel.checkFields() ? viewModel.login : null,
                  child: const Text("Login")),
              if (viewModel.state.isLoading) const CircularProgressIndicator(),
              if (viewModel.state.errorText != null)
                Text(viewModel.state.errorText!)
            ]),
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<_ViewModel>(
        create: (context) => _ViewModel(context: context),
        child: const Auth(),
      );
}
