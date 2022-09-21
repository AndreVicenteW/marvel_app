import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/add_user_comic_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/delete_user_comic_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/get_user_comics_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../domain/entities/thumbnail_entity.dart';

class ComicDetailsPage extends StatelessWidget {
  final ComicEntity comic;
  final String origin;
  final AddUserComicBloc _addUserComicBloc = Modular.get();
  final GetUserComicsBloc _getUserComicsBloc = Modular.get();
  final DeleteUserComicBloc _deleteUserComicBloc = Modular.get();

  ComicDetailsPage({
    required this.comic,
    required this.origin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var showRemove = _getUserComicsBloc.checkUserComic(comic);
    var showToRead = comic.alreadyRead || !showRemove;
    var showAlreadyRead = !comic.alreadyRead || !showRemove;

    return Scaffold(
      backgroundColor: ThemeColorHelper.primaryBlackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'comic-image-${comic.id}-$origin',
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  imageScale: 0.5,
                  image: comic.thumb.getThumbPath(size: ThumbnailSize.uncanny),
                  placeholderScale: 0.5,
                  imageErrorBuilder: (_, __, ___) {
                    return Icon(Icons.error);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ThemeText(
              text: comic.title,
              color: ThemeColorHelper.primaryWhiteColor,
              style: ThemeTextStyleHelper.headline2,
            ),
            ThemeText(
              text: '${comic.alreadyRead}',
              color: ThemeColorHelper.primaryWhiteColor,
              style: ThemeTextStyleHelper.headline2,
            ),
            SizedBox(
              height: 12,
            ),
            ThemeText(
              text: comic.getDescription(),
              color: ThemeColorHelper.primaryWhiteColor,
              style: ThemeTextStyleHelper.body2,
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      )),
      bottomNavigationBar: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _addUserComicBloc,
            listener: (context, state) {
              if(state is SuccessState && state.data is bool) {
                _getUserComicsBloc();
                showRemove = true;
                showToRead = state.data;
                showAlreadyRead = !state.data;
              }
            },
          ),
          BlocListener(
            bloc: _deleteUserComicBloc,
            listener: (context, state) {
              if(state is SuccessState) {
                _getUserComicsBloc();
                showRemove = false;
                showToRead = true;
                showAlreadyRead = true;
              }
            },
          )
        ],

        child: BlocBuilder(
            bloc: _getUserComicsBloc,
            builder: (context, state) {

              return Container(
                color: ThemeColorHelper.primaryDarkColor,
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                child: Row(
                  children: [
                    if (showToRead)
                      Expanded(
                        child: ThemeButton(
                          text: 'To read',
                          color: ThemeColorHelper.primaryBlueColor,
                          onPressed: () {
                            _addUserComicBloc(comic, false);
                          },
                        ),
                      ),
                    if (showToRead)
                      SizedBox(
                        width: 24,
                      ),
                    if (showAlreadyRead)
                      Expanded(
                        child: ThemeButton(
                          text: 'Already read',
                          color: ThemeColorHelper.primaryGreenColor,
                          onPressed: () {
                            _addUserComicBloc(comic, true);
                          },
                        ),
                      ),
                    if (!showToRead && showRemove)
                      SizedBox(
                        width: 24,
                      ),
                    if (showRemove)
                      Expanded(
                        child: ThemeButton(
                          text: 'Remove',
                          color: ThemeColorHelper.primaryRedColor,
                          onPressed: () {
                            _deleteUserComicBloc(comic);
                          },
                        ),
                      ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
