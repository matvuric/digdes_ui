import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/models/user.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});

  Future<TokenResponse?> getRefreshToken({required String refreshToken});

  Future<User?> getUser();
}
