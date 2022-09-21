import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/get_user_comics_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/components/comic_list_tile.dart';

class UserComicsPage extends StatelessWidget {
  final bool read;
  final GetUserComicsBloc _getUserComicsBloc = Modular.get();

  UserComicsPage({
    required this.read,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColorHelper.primarySilverColor,
      appBar: AppBar(
        backgroundColor: ThemeColorHelper.primarySilverColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ThemeColorHelper.primaryDarkColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder(
                    bloc: _getUserComicsBloc,
                    builder: (context, state) {
                      var comicsList = read
                          ? _getUserComicsBloc.listRead
                          : _getUserComicsBloc.listToRead;

                      return ListView.separated(
                        itemCount: comicsList.length,
                        primary: false,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 24),
                            height: 1,
                            color: ThemeColorHelper.primaryGreyColor
                                .withOpacity(0.2),
                          );
                        },
                        itemBuilder: (context, index) {
                          var _item = comicsList[index];
                          return ComicListTile(
                            comic: _item,
                            origin: 'user-page',
                          );
                        },
                      );
                    }),
              ],
            )),
      ),
    );
  }
}
