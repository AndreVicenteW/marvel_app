enum ThumbnailSize {
  small,
  medium,
  xlarge,
  fantastic,
  uncanny,
  incredible,
}

class ThumbnailEntity {
  final String path;
  final String extension;

  ThumbnailEntity(
    this.path,
    this.extension,
  );

  String getThumbPath({ThumbnailSize size = ThumbnailSize.medium}) {
    return '$path/portrait_${size.name}.$extension';
  }
}
