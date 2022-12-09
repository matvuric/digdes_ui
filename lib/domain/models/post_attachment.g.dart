// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAttachment _$PostAttachmentFromJson(Map<String, dynamic> json) =>
    PostAttachment(
      id: json['id'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      attachmentLink: json['attachmentLink'] as String,
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$PostAttachmentToJson(PostAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'attachmentLink': instance.attachmentLink,
      'postId': instance.postId,
    };
