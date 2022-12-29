import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_profile.g.dart';

@JsonSerializable()
class CreateProfile {
  late String username;
  late String firstName;
  late String lastName;
  late String bio;
  late String gender;
  late String phone;
  late String email;
  late String password;
  late String retryPassword;
  late DateTime birthDate;
  late bool isPrivate;
  late AttachmentMeta? image;

  CreateProfile({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.gender,
    required this.phone,
    required this.email,
    required this.password,
    required this.retryPassword,
    required this.birthDate,
    required this.isPrivate,
    this.image,
  });

  factory CreateProfile.fromJson(Map<String, dynamic> json) =>
      _$CreateProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProfileToJson(this);
}
