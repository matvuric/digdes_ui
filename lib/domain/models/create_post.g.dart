// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePost _$CreatePostFromJson(Map<String, dynamic> json) => CreatePost(
      authorId: json['authorId'] as String,
      caption: json['caption'] as String?,
      postAttachments: (json['postAttachments'] as List<dynamic>)
          .map((e) => AttachmentMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePostToJson(CreatePost instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'caption': instance.caption,
      'postAttachments': instance.postAttachments,
    };
