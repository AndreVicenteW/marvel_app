import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class ComicListTile extends StatelessWidget {
  final ComicEntity comic;
  final String origin;

  const ComicListTile({
    required this.comic,
    required this.origin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/home/comic/$origin', arguments: comic);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              child: Hero(
                tag: 'comic-image-${comic.id}-$origin',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    imageScale: 0.5,
                    image:
                        comic.thumb.getThumbPath(size: ThumbnailSize.uncanny),
                    placeholderScale: 0.5,
                    imageErrorBuilder: (_, __, ___) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  color: ThemeColorHelper.primaryBlackColor.withOpacity(0.3),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ThemeText(
                    text: comic.title,
                    color: ThemeColorHelper.primaryWhiteColor,
                    style: ThemeTextStyleHelper.subtitle1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
