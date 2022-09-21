// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicDto _$ComicDtoFromJson(Map<String, dynamic> json) => ComicDto(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String?,
      ThumbnailDto.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['read'] as int?,
    );

Map<String, dynamic> _$ComicDtoToJson(ComicDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'read': instance.read,
    };
