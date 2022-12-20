import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_post.g.dart';

@JsonSerializable()
class CreatePost {
  final String authorId;
  late String? caption;
  late List<AttachmentMeta> postAttachments;

  CreatePost({
    required this.authorId,
    this.caption,
    required this.postAttachments,
  });

  factory CreatePost.fromJson(Map<String, dynamic> json) =>
      _$CreatePostFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostToJson(this);
}
