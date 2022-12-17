// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:digdes_ui/domain/db_model.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DbModel {
  // TODO : extend post model
  @override
  final String id;
  final String caption;
  final DateTime createdDate;
  final String? authorId;

  Post({
    required this.id,
    required this.caption,
    required this.createdDate,
    this.authorId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromMap(Map<String, dynamic> map) => _$PostFromJson(map);

  @override
  Map<String, dynamic> toMap() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? caption,
    DateTime? createdDate,
    String? authorId,
  }) {
    return Post(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      createdDate: createdDate ?? this.createdDate,
      authorId: authorId ?? this.authorId,
    );
  }
}
