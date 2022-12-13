import 'package:digdes_ui/domain/db_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DbModel {
  @override
  late String id;
  late String username;
  late String firstName;
  late String lastName;
  late String bio;
  late String gender;
  late String phone;
  late String email;
  late String birthDate;
  late int postsCount;
  late int followersCount;
  late int followingsCount;
  late int likesCount;
  late int dislikesCount;
  late String? avatarLink;
  late bool isPrivate;

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

  User.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    username = map["username"];
    firstName = map["firstName"];
    lastName = map["lastName"];
    bio = map["bio"];
    gender = map["gender"];
    phone = map["phone"];
    email = map["email"];
    birthDate = map["birthDate"];
    isPrivate = map["isPrivate"] == 1;
    postsCount = map["postsCount"];
    followersCount = map["followersCount"];
    followingsCount = map["followingsCount"];
    likesCount = map["likesCount"];
    dislikesCount = map["dislikesCount"];
    avatarLink = map["avatarLink"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['bio'] = bio;
    map['gender'] = gender;
    map['phone'] = phone;
    map['email'] = email;
    map['birthDate'] = birthDate;
    map['isPrivate'] = isPrivate;
    map['postsCount'] = postsCount;
    map['followersCount'] = followersCount;
    map['followingsCount'] = followingsCount;
    map['likesCount'] = likesCount;
    map['dislikesCount'] = dislikesCount;
    map['avatarLink'] = avatarLink;
    map['isPrivate'] = isPrivate ? 1 : 0;
    return map;
  }
}

class IntToBoolConverter implements JsonConverter<int, bool> {
  const IntToBoolConverter();

  @override
  int fromJson(bool json) => json ? 1 : 0;

  @override
  bool toJson(int object) => object == 1;
}
