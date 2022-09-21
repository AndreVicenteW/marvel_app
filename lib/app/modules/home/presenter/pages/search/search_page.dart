import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/helpers/debounce_helper.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/enums/search_type.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/components/character_list_tile.dart';
import 'package:marvel_app/app/modules/home/presenter/components/comic_list_tile.dart';

class SearchPage extends StatefulWidget {
  final SearchType? type;
  final int? characterId;

  const SearchPage({
    Key? key,
    this.type,
    this.characterId,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  late SearchBloc _searchBloc;
  final _debounce = DebounceHelper(milliseconds: 1000);
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchBloc = widget.type == SearchType.characters
        ? Modular.get<SearchBloc<CharacterEntity>>()
        : Modular.get<SearchBloc<ComicEntity>>();

    _searchBloc('', characterId: widget.characterId);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          (_searchController.text.isNotEmpty || widget.characterId != null)) {
        _searchBloc(_searchController.text,
            pagination: true, characterId: widget.characterId);
      }
    });
  }

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
        title: widget.characterId == null
            ? TextFormField(
                textInputAction: TextInputAction.search,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search ${widget.type?.name}',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    color: ThemeColorHelper.primaryDarkColor,
                    onPressed: () {
                      _searchController.clear();
                      _searchBloc('');
                    },
                  ),
                ),
                onChanged: (value) {
                  _debounce.run(() {
                    if (value.length > 2 || value.isEmpty) {
                      _searchBloc(value);
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  });
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
            padding: EdgeInsets.all(26),
            child: Column(
              children: [
                BlocBuilder(
                  bloc: _searchBloc,
                  builder: (context, state) {
                    if (state is SuccessState ||
                        (state is LoadingState &&
                            _searchBloc.list.isNotEmpty)) {
                      return _getList(_searchBloc.list, state is LoadingState);
                    } else if (state is ErrorState) {
                      return _getErrorMessage();
                    }
                    return _getLoading();
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget _getList(List list, bool showLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.characterId == null)
          ThemeText(
            text: _searchController.text.isEmpty
                ? 'The most famous'
                : 'Results for "${_searchController.text}"',
            color: ThemeColorHelper.primaryGreyColor,
          ),
        SizedBox(
          height: 26,
        ),
        ListView.separated(
          itemCount: list.length,
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              height: 1,
              color: ThemeColorHelper.primaryGreyColor.withOpacity(0.2),
            );
          },
          itemBuilder: (context, index) {
            var _item = list[index];
            if (widget.type == SearchType.characters) {
              return CharacterListTile(character: _item);
            } else {
              return ComicListTile(
                comic: _item,
                origin: 'search',
              );
            }
          },
        ),
        if (showLoading)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: _getLoading(),
          )
      ],
    );
  }

  Widget _getLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getErrorMessage() {
    return ThemeText(text: 'Error, please try again later');
  }
}
