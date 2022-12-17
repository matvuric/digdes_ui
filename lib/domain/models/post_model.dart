import 'package:digdes_ui/domain/models/post_attachment.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String id;
  String? caption;
  DateTime createdDate;
  User author;
  List<PostAttachment> postAttachments;
  PostModel({
    required this.id,
    this.caption,
    required this.createdDate,
    required this.author,
    required this.postAttachments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
