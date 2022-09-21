// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) => CharacterDto(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      ThumbnailDto.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['comics'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CharacterDtoToJson(CharacterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'comics': instance.comics,
    };
