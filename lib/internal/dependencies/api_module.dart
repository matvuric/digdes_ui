import 'package:digdes_ui/data/clients/api_client.dart';
import 'package:digdes_ui/data/clients/auth_client.dart';
import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/domain/models/refresh_token_request.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:digdes_ui/ui/navigation/app_navigator.dart';
import 'package:dio/dio.dart';

class ApiModule {
  static AuthClient? _authClient;
  static ApiClient? _apiClient;

  static AuthClient auth() =>
      _authClient ??
      AuthClient(
        Dio(),
        baseUrl: baseUrl,
      );

  static ApiClient api() =>
      _apiClient ??
      ApiClient(
        _addInterceptors(Dio()),
        baseUrl: baseUrl,
      );

  static Dio _addInterceptors(Dio dio) {
    dio.interceptors
        .add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
      final token = await TokenStorage.getAccessToken();
      options.headers.addAll({"Authorization": "Bearer $token"});
      return handler.next(options);
    }, onError: ((e, handler) async {
      if (e.response?.statusCode == 401) {
        RequestOptions options = e.response!.requestOptions;
        var refreshToken = await TokenStorage.getRefreshToken();
        try {
          if (refreshToken != null) {
            var token = await auth().getRefreshToken(
                RefreshTokenRequest(refreshToken: refreshToken));
            await TokenStorage.setStoredToken(token);
            options.headers["Authorization"] = "Bearer ${token!.accessToken}";
          }
        } catch (e) {
          var service = AuthService();
          await service.logOut();
          AppNavigator.toLoader();
          return handler
              .resolve(Response(statusCode: 400, requestOptions: options));
        }

        return handler.resolve(await dio.fetch(options));
      } else {
        return handler.next(e);
      }
    })));
    return dio;
  }
}
