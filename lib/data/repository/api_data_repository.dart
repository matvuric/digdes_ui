import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:digdes_ui/domain/models/token_request.dart';
import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:digdes_ui/domain/repository/api_repository.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  ApiDataRepository(this._auth);

  @override
  Future<TokenResponse?> getToken(
      {required String login, required String password}) async {
    return await _auth.getToken(TokenRequest(login: login, password: password));
  }
}
