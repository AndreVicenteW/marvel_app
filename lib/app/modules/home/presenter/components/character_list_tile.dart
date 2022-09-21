import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class CharacterListTile extends StatelessWidget {

  final CharacterEntity character;

  const CharacterListTile({
    required this.character,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/home/character',
          arguments: character
        );
      },
      child: Row(
        children: [
          Container(
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: 'character-image-${character.id}',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: character.thumb.getThumbPath(),
                  imageErrorBuilder: (_, __,___) {
                    return Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ThemeText(
                  text: character.name,
                  color: ThemeColorHelper.primaryDarkColor,
                  style: ThemeTextStyleHelper.headline3,
                ),
                SizedBox(
                  height: 8,
                ),
                ThemeText(
                  text: character.getDescription(),
                  color: ThemeColorHelper.primaryDarkColor,
                  style: ThemeTextStyleHelper.body2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
