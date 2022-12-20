import 'dart:io';

import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:digdes_ui/domain/models/create_post.dart';
import 'package:digdes_ui/domain/models/edit_profile.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST("api/User/EditUserProfile")
  Future editProfile(@Body() EditProfile model);

  @POST("api/Attachment/UploadFiles")
  Future<List<AttachmentMeta>> uploadTemp(
      {@Part(name: "files") required List<File> files});

  @POST("api/User/SetAvatar")
  Future setAvatar(@Body() AttachmentMeta model);

  @POST("api/Post/CreatePost")
  Future createPost(@Body() CreatePost model);

  @GET("api/User/GetCurrentUser")
  Future<User?> getUser();

  @GET("api/Post/GetPosts")
  Future<List<PostModel>> getPosts(
      @Query("skip") int skip, @Query("take") int take);
}
