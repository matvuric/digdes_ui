// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfile _$EditProfileFromJson(Map<String, dynamic> json) => EditProfile(
      username: json['username'] as String?,
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
    );

Map<String, dynamic> _$EditProfileToJson(EditProfile instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bio': instance.bio,
      'gender': instance.gender,
      'phone': instance.phone,
      'email': instance.email,
      'birthDate': instance.birthDate?.toIso8601String(),
      'isPrivate': instance.isPrivate,
    };
