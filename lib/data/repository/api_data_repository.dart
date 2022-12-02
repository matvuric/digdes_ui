import 'package:digdes_ui/data/clients/api_client.dart';
import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:digdes_ui/domain/models/refresh_token_request.dart';
import 'package:digdes_ui/domain/models/token_request.dart';
import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/domain/repository/api_repository.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;

  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken(
      {required String login, required String password}) async {
    return await _auth.getToken(TokenRequest(login: login, password: password));
  }

  @override
  Future<TokenResponse?> getRefreshToken({required String refreshToken}) async {
    return await _auth
        .getRefreshToken(RefreshTokenRequest(refreshToken: refreshToken));
  }

  @override
  Future<User?> getUser() => _api.getUser();
}
