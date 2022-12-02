// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      username: json['username'] as String,
      postsCount: json['postsCount'] as int,
      followersCount: json['followersCount'] as int,
      followingsCount: json['followingsCount'] as int,
      likesCount: json['likesCount'] as int,
      dislikesCount: json['dislikesCount'] as int,
      avatarLink: json['avatarLink'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'postsCount': instance.postsCount,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
      'likesCount': instance.likesCount,
      'dislikesCount': instance.dislikesCount,
      'avatarLink': instance.avatarLink,
    };
