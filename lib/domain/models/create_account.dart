import 'package:digdes_ui/domain/models/attachment_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account.g.dart';

@JsonSerializable()
class CreateAccount {
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

  CreateAccount({
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

  factory CreateAccount.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountToJson(this);
}
