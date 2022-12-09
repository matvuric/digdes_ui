import 'package:digdes_ui/domain/models/post_attachment.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String id;
  String? caption;
  User author;
  List<PostAttachment> postAttachments;
  // TODO : NOT NULL in back
  PostModel({
    required this.id,
    this.caption,
    required this.author,
    required this.postAttachments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
