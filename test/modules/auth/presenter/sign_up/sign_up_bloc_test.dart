import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/usecases/sign_up/sign_up_usecase.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_bloc.dart';
import 'package:mocktail/mocktail.dart';

class SignUpUseCaseMock extends Mock implements SignUpUseCase {}

void main() {

  late SignUpUseCase _signInUseCase;

  final _userEntity = UserEntity(
    id: '1',
    email: 'test@test.com',
    password: '123',
    name: 'test',
  );

  setUpAll(() {
    _signInUseCase = SignUpUseCaseMock();
    registerFallbackValue(_userEntity);
  });

  group('[Sign Up Bloc Tests]', () {

    blocTest<SignUpBloc, BaseBlocState>(
      'Should emit [LoadingState, SuccessState] when successful',
      build: () => SignUpBlocImp(_signInUseCase),
      setUp: () => when(() => _signInUseCase(any()))
          .thenAnswer((_) async => DataResult.success(_userEntity)),
      act: (bloc) {
        bloc(_userEntity);
      },
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState<DataResult<UserEntity>>>(),
      ],
    );

    blocTest<SignUpBloc, BaseBlocState>(
      'Should emit [LoadingState, ErrorState] when error',
      build: () => SignUpBlocImp(_signInUseCase),
      setUp: () => when(() => _signInUseCase(any()))
          .thenAnswer((_) async => DataResult.failure(GenericFailure('Error'))),
      act: (bloc) {
        bloc(_userEntity);
      },
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );
  });
}
