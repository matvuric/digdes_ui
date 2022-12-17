// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:digdes_ui/domain/db_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DbModel {
  @override
  late String id;
  late String username;
  late String? firstName;
  late String? lastName;
  late String? bio;
  late String? gender;
  late String? phone;
  late String? email;
  late DateTime? birthDate;
  late int? postsCount;
  late int followersCount;
  late int followingsCount;
  late int? likesCount;
  late int? dislikesCount;
  late String? avatarLink;
  late bool? isPrivate;

  User({
    // TODO : make another model
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.bio,
    this.gender,
    this.phone,
    this.email,
    this.birthDate,
    this.isPrivate,
    this.postsCount,
    required this.followersCount,
    required this.followingsCount,
    this.likesCount,
    this.dislikesCount,
    this.avatarLink,
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
    birthDate = map["birthDate"] == null
        ? null
        : DateTime.parse(map['birthDate'] as String);
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
    map['birthDate'] = birthDate.toString();
    map['isPrivate'] = isPrivate;
    map['postsCount'] = postsCount;
    map['followersCount'] = followersCount;
    map['followingsCount'] = followingsCount;
    map['likesCount'] = likesCount;
    map['dislikesCount'] = dislikesCount;
    map['avatarLink'] = avatarLink;
    map['isPrivate'] = isPrivate! ? 1 : 0;
    return map;
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.bio == bio &&
        other.gender == gender &&
        other.phone == phone &&
        other.email == email &&
        other.birthDate == birthDate &&
        other.postsCount == postsCount &&
        other.followersCount == followersCount &&
        other.followingsCount == followingsCount &&
        other.likesCount == likesCount &&
        other.dislikesCount == dislikesCount &&
        other.avatarLink == avatarLink &&
        other.isPrivate == isPrivate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        bio.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        birthDate.hashCode ^
        postsCount.hashCode ^
        followersCount.hashCode ^
        followingsCount.hashCode ^
        likesCount.hashCode ^
        dislikesCount.hashCode ^
        avatarLink.hashCode ^
        isPrivate.hashCode;
  }
}
