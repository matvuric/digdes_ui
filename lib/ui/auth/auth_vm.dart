import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:digdes_ui/ui/auth/account_creator/account_creator.dart';
import 'package:flutter/material.dart';

class ViewModelState {
  late String? login;
  late String? password;
  final bool isLoading;
  final String? errorText;
  ViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  ViewModelState copyWith({
    String? login,
    String? password,
    bool? isLoading = false,
    String? errorText,
  }) {
    return ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  BuildContext context;
  AuthViewModel({required this.context}) {
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

  var _state = ViewModelState();
  ViewModelState get state => _state;
  set state(ViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields([String login = '', String password = '']) {
    if (login.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.auth(state.login, state.password).then((value) {
        AppNavigator.toLoader()
            .then((value) => state = state.copyWith(isLoading: false));
      });
    } on NoNetworkException {
      state = state.copyWith(errorText: "No Network");
    } on WrongCredentialsException {
      state = state.copyWith(errorText: "Incorrect login or password");
    } on ServerException {
      state = state.copyWith(errorText: "Server not responding");
    }
  }

  void toSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (__) => AccountCreator.create()));
  }
}
