import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST("api/User/EditUserProfile")
  Future editProfile(@Body() EditProfile body);

  @GET("api/User/GetCurrentUser")
  Future<User?> getUser();
}
