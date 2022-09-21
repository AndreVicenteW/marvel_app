import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

part 'thumbnail_dto.g.dart';

@JsonSerializable()
class ThumbnailDto extends ThumbnailEntity {

  @override
  final String path;
  @override
  final String extension;

  ThumbnailDto(this.path,
      this.extension) : super(path, extension);

  factory ThumbnailDto.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailDtoToJson(this);

  factory ThumbnailDto.fromEntity(ThumbnailEntity entity) =>
      ThumbnailDto(entity.path, entity.extension,);
}