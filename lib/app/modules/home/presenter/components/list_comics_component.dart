import 'package:flutter/material.dart';
import 'package:marvel_app/app/modules/home/presenter/components/comic_list_tile.dart';

import '../../domain/entities/comic_entity.dart';

class ListComicsComponent extends StatelessWidget {
  final List<ComicEntity> comics;

  const ListComicsComponent({
    required this.comics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: comics.isNotEmpty ? 200 : 0,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: comics.length,
        itemBuilder: (context, index) {
          var comic = comics[index];

          return Container(
              padding: index == 0
                  ? EdgeInsets.only(left: 26)
                  : index == comics.length - 1
                      ? EdgeInsets.only(right: 26)
                      : null,
              child: ComicListTile(
                comic: comic,
                origin: 'list-comics',
              ));
        },
        separatorBuilder: (context, index) {
          return Container(width: 16);
        },
      ),
    );
  }
}
