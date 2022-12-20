import 'package:json_annotation/json_annotation.dart';

part 'edit_profile.g.dart';

@JsonSerializable()
class EditProfile {
  late String? username;
  late String? firstName;
  late String? lastName;
  late String? bio;
  late String? gender;
  late String? phone;
  late String? email;
  late DateTime? birthDate;
  late bool? isPrivate;

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
