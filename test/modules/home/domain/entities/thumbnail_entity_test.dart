import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

void main() {

  var _thumbnailEntity = ThumbnailEntity(
    'path/to/file',
    'jpg',
  );

  group('Thumbnail Entity test', () {

    test('Should return correct path when getThumbPath is called with default size', () {

      final result = _thumbnailEntity.getThumbPath();
      expect(result, '${_thumbnailEntity.path}/portrait_medium.${_thumbnailEntity.extension}');
    });

    test('Should return correct path when getThumbPath is called with param size', () {

      final result = _thumbnailEntity.getThumbPath(size: ThumbnailSize.small);
      expect(result, '${_thumbnailEntity.path}/portrait_small.${_thumbnailEntity.extension}');
    });
  });
}
