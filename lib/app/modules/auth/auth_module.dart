import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_up/external/sign_up_external_datasource.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_in/sign_in_bloc.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_in/sign_in_page.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_bloc.dart';

import 'data/datasources/sign_in/external/sign_in_external_datasource.dart';
import 'data/repositories/sign_in/sign_in_repository.dart';
import 'data/repositories/sign_up/sign_up_repository.dart';
import 'domain/usecases/sign_in/sign_in_usecase.dart';
import 'domain/usecases/sign_up/sign_up_usecase.dart';

class AuthModule extends Module {

  @override
  List<Bind<Object>> get binds => [
    //Sing In
    Bind.lazySingleton((i) => SignInExternalDataSourceImp(i())),
    Bind.lazySingleton((i) => SignInRepositoryImp(i())),
    Bind.lazySingleton((i) => SignInUseCaseImp(i())),
    Bind.lazySingleton<SignInBloc>((i) => SignInBlocImp(i())),

    //Sign Up
    Bind.lazySingleton((i) => SignUpExternalDataSourceImp(i())),
    Bind.lazySingleton((i) => SignUpRepositoryImp(i())),
    Bind.lazySingleton((i) => SignUpUseCaseImp(i())),
    Bind.lazySingleton<SignUpBloc>((i) => SignUpBlocImp(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => SignInPage())
  ];
}