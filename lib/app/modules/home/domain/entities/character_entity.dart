import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String description;
  final ThumbnailEntity thumb;
  final int comicsLength;

  final String noDescriptionText = 'Sorry, no description.';

  CharacterEntity(
    this.id,
    this.name,
    this.description,
    this.thumb,
    this.comicsLength,
  );

  String getDescription() {
    return description.isNotEmpty ? description : noDescriptionText;
  }
}
