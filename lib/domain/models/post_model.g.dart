// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      caption: json['caption'] as String?,
      createdDate: DateTime.parse(json['createdDate'] as String),
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      postAttachments: (json['postAttachments'] as List<dynamic>)
          .map((e) => PostAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'createdDate': instance.createdDate.toIso8601String(),
      'author': instance.author,
      'postAttachments': instance.postAttachments,
    };
