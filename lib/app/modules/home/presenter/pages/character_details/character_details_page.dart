import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_comics_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/components/list_comics_component.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../domain/entities/comic_entity.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterEntity character;

  const CharacterDetailsPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  final ScrollController _controller = ScrollController();
  late final List<ComicEntity> comics;
  final SearchBloc _searchBloc = Modular.get<SearchComicsBlocImp>();
  late final CharacterEntity character = widget.character;

  @override
  void initState() {
    super.initState();

    _searchBloc('', characterId: character.id);
    _scrollDetailsContainer();
  }

  void _scrollDetailsContainer() {
    Future.delayed(Duration(milliseconds: 1200), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 1200),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColorHelper.primaryBlackColor,
      child: Stack(
        children: [
          Hero(
            tag: 'character-image-${character.id}',
            child: Container(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: character.thumb
                    .getThumbPath(size: ThumbnailSize.uncanny),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor:
                  ThemeColorHelper.primaryBlackColor.withOpacity(0.3),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              controller: _controller,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 1.5),
                color: ThemeColorHelper.primaryBlackColor.withOpacity(0.5),
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: ThemeText(
                        text: character.name,
                        color: ThemeColorHelper.primaryWhiteColor,
                        style: ThemeTextStyleHelper.headline2,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: ThemeText(
                        text: character.getDescription(),
                        color: ThemeColorHelper.primaryWhiteColor,
                        style: ThemeTextStyleHelper.body2,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Row(
                        children: [
                          Expanded(
                            child: ThemeText(
                              text:
                                  'Magazines (${character.comicsLength})',
                              color: ThemeColorHelper.primaryWhiteColor,
                              style: ThemeTextStyleHelper.subtitle1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/home/search/comics/${character.id}');
                            },
                            child: ThemeText(
                              text: 'See all',
                              color: ThemeColorHelper.primaryGreyColor,
                              style: ThemeTextStyleHelper.body2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BlocBuilder(
                      bloc: _searchBloc,
                      builder: (context, state) {
                        if(state is SuccessState) {
                          return ListComicsComponent(comics: state.data);
                        } else if(state is LoadingState) {
                          return _getLoading();
                        } else {
                          return Container(
                            height: 200,
                            child: ThemeText(
                              text: 'Magazines not found',
                              color: ThemeColorHelper.primaryWhiteColor,
                              style: ThemeTextStyleHelper.body1,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }
}
