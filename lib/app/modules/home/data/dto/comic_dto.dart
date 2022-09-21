import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

part 'comic_dto.g.dart';

@JsonSerializable()
class ComicDto extends ComicEntity {
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  final ThumbnailDto thumbnail;
  final int? read;

  ComicDto(this.id, this.title, this.description, this.thumbnail, this.read)
      : super(id, title, description ?? '', thumbnail, read == 1);

  factory ComicDto.fromJson(Map<String, dynamic> json) =>
      _$ComicDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ComicDtoToJson(this);

  factory ComicDto.fromEntity(ComicEntity entity) => ComicDto(
        entity.id,
        entity.title,
        entity.description,
        ThumbnailDto.fromEntity(entity.thumb),
        (entity.alreadyRead) ? 1 : 0,
      );

  Map<String, dynamic> toDatabase() {
    var json = toJson();
    json['thumbnail'] = jsonEncode(json['thumbnail']);
    return json;
  }

  factory ComicDto.fromDatabase(Map<String, dynamic> map) => ComicDto(
        map['id'] as int,
        map['title'] as String,
        map['description'] as String?,
        ThumbnailDto.fromJson(jsonDecode(map['thumbnail'])),
        map['read'] as int?,
      );
}
