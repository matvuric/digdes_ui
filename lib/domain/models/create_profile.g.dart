// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProfile _$CreateProfileFromJson(Map<String, dynamic> json) =>
    CreateProfile(
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      bio: json['bio'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      retryPassword: json['retryPassword'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      isPrivate: json['isPrivate'] as bool,
      image: json['image'] == null
          ? null
          : AttachmentMeta.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateProfileToJson(CreateProfile instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'bio': instance.bio,
      'gender': instance.gender,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'retryPassword': instance.retryPassword,
      'birthDate': instance.birthDate.toIso8601String(),
      'isPrivate': instance.isPrivate,
      'image': instance.image,
    };
