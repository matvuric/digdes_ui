import 'package:digdes_ui/internal/config/shared_preferences.dart';

class AuthService {
  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      SharedPrefs.setStoredAuth(true);
    }
  }

  Future<bool> checkAuth() async {
    return await SharedPrefs.getStoredAuth();
  }

  Future logOut() async {
    await SharedPrefs.setStoredAuth(null);
  }
}
