// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentMeta _$AttachmentMetaFromJson(Map<String, dynamic> json) =>
    AttachmentMeta(
      tempId: json['tempId'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      size: json['size'] as int,
    );

Map<String, dynamic> _$AttachmentMetaToJson(AttachmentMeta instance) =>
    <String, dynamic>{
      'tempId': instance.tempId,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
