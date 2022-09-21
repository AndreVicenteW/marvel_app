import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/auth_module.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_bloc.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_page.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/home/home_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../../tester_helper.dart';
import 'sign_up_bloc_test.dart';

void main() {
  final _signUpUseCase = SignUpUseCaseMock();
  late SignUpBloc _signUpBloc;

  void _setMockBloc() {
    initModule(AuthModule(), replaceBinds: [
      Bind.instance<SignUpBloc>(SignUpBlocImp(_signUpUseCase)),
    ]);

    _signUpBloc = Modular.get();
  }

  setUpAll(() async {
    _setMockBloc();

    registerFallbackValue(UserEntity(email: ''));
  });

  Future<void> _initPageTest(WidgetTester tester) async {
    await tester.pumpWidget(
      TesterHelper.buildTestableWidget(
        SignUpPage(),
      ),
    );

    await tester.pumpAndSettle();
  }

  group('[Sign Up page test]', () {
    testWidgets('Should see all widgets', (WidgetTester tester) async {
      await _initPageTest(tester);

      expect(find.byType(ThemeInput), findsNWidgets(3));
      expect(find.byType(ThemeButton), findsOneWidget);
      //there is one ThemeText inside ThemeButton
      expect(find.byType(ThemeText), findsNWidgets(2));
    });

    testWidgets('Should see error when tap with inputs blank',
        (WidgetTester tester) async {
      await _initPageTest(tester);

      await tester.tap(find.byType(ThemeButton));
      await tester.pumpAndSettle();

      expect(find.text('Required field'), findsNWidgets(3));
    });

    testWidgets('Should see error message with wrong credentials',
        (WidgetTester tester) async {
      when(() => _signUpUseCase(any())).thenAnswer(
        (_) async => DataResult.failure(GenericFailure('Error')),
      );

      await _initPageTest(tester);

      await tester.enterText(find.byType(TextFormField).first, 'Name test');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, '123123');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ThemeButton));

      await tester.pumpAndSettle();
      expect(find.byKey(Key('FormErrorMessage')), findsOneWidget);
    });

    testWidgets('Should receive success state with right credentials',
        (WidgetTester tester) async {

      TesterHelper.setPushReplacementNamedMock(page: HomePage());

      when(() => _signUpUseCase(any())).thenAnswer(
        (_) async => DataResult.success(UserEntity(email: '')),
      );

      await _initPageTest(tester);

      await tester.enterText(find.byType(TextFormField).first, 'Name test');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, '123123');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ThemeButton));

      await tester.pumpAndSettle();
      expect(find.byKey(Key('FormErrorMessage')), findsNothing);

      expect(_signUpBloc.state, isA<SuccessState>());
    });
  });
}
