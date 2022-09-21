import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto extends CharacterEntity {

  @override
  final int id;

  @override
  final String name;

  @override
  final String description;

  final ThumbnailDto thumbnail;

  final Map<String, dynamic> comics;

  CharacterDto(
      this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.comics
      ) : super(id, name, description, thumbnail, comics['available'] ?? 0);

  factory CharacterDto.fromJson(Map<String, dynamic> json) => _$CharacterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);
}