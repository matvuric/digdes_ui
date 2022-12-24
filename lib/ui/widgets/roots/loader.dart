import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/auth_service.dart';
import '../../navigation/app_navigator.dart';

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  BuildContext context;
  _ViewModel({required this.context}) {
    asyncInit();
  }

  Future asyncInit() async {
    if (await _authService.checkAuth()) {
      AppNavigator.toHome();
    } else {
      AppNavigator.toAuth();
    }
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget create() => ChangeNotifierProvider<_ViewModel>(
        create: (context) => _ViewModel(context: context),
        lazy: false,
        child: const Loader(),
      );
}
