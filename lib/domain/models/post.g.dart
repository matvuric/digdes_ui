// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      caption: json['caption'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'createdDate': instance.createdDate.toIso8601String(),
      'authorId': instance.authorId,
    };
