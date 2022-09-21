import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/internal/add_user_comic_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/internal/delete_user_comic_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/external/get_characters_external_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/internal/get_characters_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/external/get_comics_external_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/internal/get_comics_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/internal/get_user_comics_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/repositories/add_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/data/repositories/delete_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_characters_repository.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_comics_repository.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_user_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/add_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/delete_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_user_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/add_user_comic_usecase.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/delete_user_comic_usecase.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_characters_usecase.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_comics_usecase.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_user_comics_usecase.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_characters_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_comics_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/add_user_comic_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/delete_user_comic_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/get_user_comics_bloc.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/character_details/character_details_page.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/comic_details/comic_details_page.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/home/home_page.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/search/search_page.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/user_comics/user_comics_page.dart';

import 'domain/enums/search_type.dart';
import 'domain/repositories/get_characters_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //Get Characters
        Bind.lazySingleton<GetCharactersRepository>(
          (i) => GetCharactersRepositoryImp(
            GetCharactersExternalDataSourceImp(i()),
            GetCharactersInternalDataSourceImp(rootBundle),
          ),
        ),
        Bind.lazySingleton<GetCharactersUseCase>(
          (i) => GetCharactersUseCaseImp(i()),
        ),
        Bind.lazySingleton<SearchBloc>(
          (i) => SearchCharactersBlocImp(i()),
        ),

        //Get Comics
        Bind.lazySingleton<GetComicsRepository>(
          (i) => GetComicsRepositoryImp(
            GetComicsExternalDataSourceImp(i()),
            GetComicsInternalDataSourceImp(rootBundle),
          ),
        ),
        Bind.lazySingleton<GetComicsUseCase>(
          (i) => GetComicsUseCaseImp(i()),
        ),
        Bind.lazySingleton<SearchBloc>(
          (i) => SearchComicsBlocImp(i()),
        ),

        //Get User Comics
        Bind.lazySingleton<GetUserComicsRepository>(
          (i) => GetUserComicsRepositoryImp(
            GetUserComicsInternalDataSourceImp(i()),
          ),
        ),
        Bind.lazySingleton<GetUserComicsUseCase>(
          (i) => GetUserComicsUseCaseImp(i()),
        ),
        Bind.lazySingleton<GetUserComicsBloc>(
          (i) => GetUserComicsBlocImp(i()),
        ),

        //Add User Comic
        Bind.lazySingleton<AddUserComicRepository>(
          (i) => AddUserComicRepositoryImp(
            AddUserComicInternalDataSourceImp(i()),
          ),
        ),
        Bind.lazySingleton<AddUserComicUseCase>(
          (i) => AddUserComicUseCaseImp(i()),
        ),
        Bind.lazySingleton<AddUserComicBloc>(
          (i) => AddUserComicBlocImp(i(), i()),
        ),

        //Delete User Comic
        Bind.lazySingleton<DeleteUserComicRepository>(
          (i) => DeleteUserComicRepositoryImp(
            DeleteUserComicInternalDataSourceImp(i()),
          ),
        ),
        Bind.lazySingleton<DeleteUserComicUseCase>(
          (i) => DeleteUserComicUseCaseImp(i()),
        ),
        Bind.lazySingleton<DeleteUserComicBloc>(
          (i) => DeleteUserComicBlocImp(i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HomePage()),
        ChildRoute(
          '/search/:type/:characterId',
          child: (context, args) => SearchPage(
            type: SearchType.fromName(args.params['type']),
            characterId: int.tryParse(args.params['characterId']),
          ),
        ),
        ChildRoute(
          '/character',
          child: (context, args) => CharacterDetailsPage(character: args.data),
        ),
        ChildRoute(
          '/comic/:origin',
          child: (context, args) => ComicDetailsPage(
            comic: args.data,
            origin: args.params['origin'],
          ),
        ),
        ChildRoute(
          '/user-comics/',
          child: (context, args) => UserComicsPage(read: args.data),
        ),
      ];
}
