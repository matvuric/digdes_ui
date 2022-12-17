// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      isPrivate: json['isPrivate'] as bool?,
      postsCount: json['postsCount'] as int?,
      followersCount: json['followersCount'] as int,
      followingsCount: json['followingsCount'] as int,
      likesCount: json['likesCount'] as int?,
      dislikesCount: json['dislikesCount'] as int?,
      avatarLink: json['avatarLink'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bio': instance.bio,
      'gender': instance.gender,
      'phone': instance.phone,
      'email': instance.email,
      'birthDate': instance.birthDate?.toIso8601String(),
      'postsCount': instance.postsCount,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
      'likesCount': instance.likesCount,
      'dislikesCount': instance.dislikesCount,
      'avatarLink': instance.avatarLink,
      'isPrivate': instance.isPrivate,
    };
