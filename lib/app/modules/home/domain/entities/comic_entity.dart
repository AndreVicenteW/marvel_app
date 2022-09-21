import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

class ComicEntity {
  final int id;
  final String title;
  final String? description;
  final ThumbnailEntity thumb;
  final bool alreadyRead;

  final String noDescriptionText = 'Sorry, no description.';

  ComicEntity(
      this.id, this.title, this.description, this.thumb, this.alreadyRead);

  String getDescription() {
    return description != null && description!.isNotEmpty
        ? description!
        : noDescriptionText;
  }

  ComicEntity copyWith(
      {int? id,
      String? title,
      String? description,
      ThumbnailEntity? thumb,
      bool? alreadyRead}) {
    return ComicEntity(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      thumb ?? this.thumb,
      alreadyRead ?? this.alreadyRead,
    );
  }
}
