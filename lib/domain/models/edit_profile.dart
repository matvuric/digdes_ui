import 'package:json_annotation/json_annotation.dart';

part 'edit_profile.g.dart';

@JsonSerializable()
class EditProfile {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? gender;
  final String? phone;
  final String? email;
  final DateTime? birthDate;
  final bool? isPrivate;

  EditProfile({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.gender,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.isPrivate,
  });

  factory EditProfile.fromJson(Map<String, dynamic> json) =>
      _$EditProfileFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileToJson(this);
}
