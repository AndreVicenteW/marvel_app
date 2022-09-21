import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/get_user_comics_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/components/list_comics_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetUserComicsBloc _getUserComicsBloc = Modular.get();

  @override
  void initState() {
    super.initState();

    _getUserComicsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColorHelper.primarySilverColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColorHelper.primarySilverColor,
        elevation: 0,
        title: Container(
          height: 26,
          child: ThemeImage(
            image: ThemeImages.logo,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: ThemeText(
                  text: 'Search magazines by:',
                  style: ThemeTextStyleHelper.body1,
                  color: ThemeColorHelper.primaryGreyColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ThemeIconButton(
                        text: 'Characters',
                        color: ThemeColorHelper.primaryBlueColor,
                        gradientColor: ThemeGradientHelper.gradientBlue,
                        icon: Icons.person_outline,
                        onPressed: () {
                          Modular.to.pushNamed('/home/search/characters');
                        },
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(
                      child: ThemeIconButton(
                        text: 'Magazines',
                        color: ThemeColorHelper.secondaryPurpleColor,
                        gradientColor: ThemeGradientHelper.gradientPurple,
                        icon: Icons.article_outlined,
                        onPressed: () {
                          Modular.to.pushNamed('/home/search/comics/');
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 44,
              ),
              BlocBuilder(
                  bloc: _getUserComicsBloc,
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return _getLoading();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: Row(
                            children: [
                              Expanded(
                                child: ThemeText(
                                  text:
                                      'Comics to read (${_getUserComicsBloc.listToRead.length})',
                                  color: ThemeColorHelper.primaryRedColor,
                                  style: ThemeTextStyleHelper.subtitle1,
                                ),
                              ),
                              if (_getUserComicsBloc.listToRead.length > 2)
                                GestureDetector(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                      '/home/user-comics/',
                                      arguments: false,
                                    );
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
                        ListComicsComponent(
                          comics: _getUserComicsBloc.listToRead,
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: Row(
                            children: [
                              Expanded(
                                child: ThemeText(
                                  text:
                                      'Comics already read (${_getUserComicsBloc.listRead.length})',
                                  color: ThemeColorHelper.primaryRedColor,
                                  style: ThemeTextStyleHelper.subtitle1,
                                ),
                              ),
                              if (_getUserComicsBloc.listRead.length > 2)
                                GestureDetector(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                      '/home/user-comics/',
                                      arguments: true,
                                    );
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
                        ListComicsComponent(
                            comics: _getUserComicsBloc.listRead),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }
}
