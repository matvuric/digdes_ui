import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:dio/dio.dart';

String baseUrl = "http://192.168.56.1:5050/";

class ApiModule {
  static AuthClient? _authClient;

  static AuthClient auth() =>
      _authClient ??
      AuthClient(
        Dio(),
        baseUrl: baseUrl,
      );
}
