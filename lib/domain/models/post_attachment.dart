import 'package:digdes_ui/domain/db_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_attachment.g.dart';

@JsonSerializable()
class PostAttachment implements DbModel {
  @override
  final String id;
  final String name;
  final String mimeType;
  final String attachmentLink;
  final String? postId;

  PostAttachment({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.attachmentLink,
    this.postId,
  });

  factory PostAttachment.fromJson(Map<String, dynamic> json) =>
      _$PostAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$PostAttachmentToJson(this);

  factory PostAttachment.fromMap(Map<String, dynamic> map) =>
      _$PostAttachmentFromJson(map);

  @override
  Map<String, dynamic> toMap() => _$PostAttachmentToJson(this);

  PostAttachment copyWith({
    String? id,
    String? name,
    String? mimeType,
    String? attachmentLink,
    String? postId,
  }) {
    return PostAttachment(
        id: id ?? this.id,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        attachmentLink: attachmentLink ?? this.attachmentLink,
        postId: postId ?? this.postId);
  }
}
