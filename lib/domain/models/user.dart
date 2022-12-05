import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String bio;
  final String gender;
  final String phone;
  final String email;
  final String birthDate;
  final bool isPrivate;
  final int postsCount;
  final int followersCount;
  final int followingsCount;
  final int likesCount;
  final int dislikesCount;
  final String? avatarLink;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.gender,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.isPrivate,
    required this.postsCount,
    required this.followersCount,
    required this.followingsCount,
    required this.likesCount,
    required this.dislikesCount,
    required this.avatarLink,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
