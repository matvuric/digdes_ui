import 'package:json_annotation/json_annotation.dart';

part 'attachment_meta.g.dart';

@JsonSerializable()
class AttachmentMeta {
  final String tempId;
  final String name;
  final String mimeType;
  final int size;

  AttachmentMeta({
    required this.tempId,
    required this.name,
    required this.mimeType,
    required this.size,
  });

  factory AttachmentMeta.fromJson(Map<String, dynamic> json) =>
      _$AttachmentMetaFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentMetaToJson(this);
}
