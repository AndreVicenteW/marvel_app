import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/components/theme_bottom_sheet.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_in/sign_in_bloc.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_page.dart';
import 'package:validatorless/validatorless.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final SignInBloc _signInBloc = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColorHelper.primarySilverColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      child: ThemeImage(
                        image: ThemeImages.logo,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ThemeInput(
                            controller: _emailController,
                            placeholder: 'E-mail',
                            icon: Icons.mail_outline,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validatorless.multiple([
                              Validatorless.email('Invalid e-mail'),
                              Validatorless.required('Required field')
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ThemeInput(
                            controller: _passwordController,
                            placeholder: 'Password',
                            icon: Icons.lock_outline,
                            password: true,
                            textInputAction: TextInputAction.done,
                            validator: Validatorless.multiple([
                              Validatorless.required('Required field'),
                              Validatorless.min(3, 'Minimum 3 digits')
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocConsumer(
                            bloc: _signInBloc,
                            listener: (context, state) {
                              if (state is SuccessState) {
                                Modular.to.pushReplacementNamed('/home/');
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (state is ErrorState) ...[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 26,
                                        right: 26,
                                        bottom: 20,
                                      ),
                                      child: ThemeText(
                                        key: Key('FormErrorMessage'),
                                        text: state.message,
                                        color: ThemeColorHelper.primaryRedColor,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                  ThemeButton(
                                    text: 'Sign In',
                                    loading: state is LoadingState,
                                    onPressed: () {
                                      //Modular.to.pushReplacementNamed('/home/');
                                      if (_formKey.currentState!.validate()) {
                                        _signInBloc(
                                          UserEntity(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ThemeText(
                        text: 'Don\'t have a account?',
                        style: ThemeTextStyleHelper.body1,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          _openSignUpBottomSheet(context);
                        },
                        child: ThemeText(
                          text: 'Sign up',
                          style: ThemeTextStyleHelper.subtitle2,
                          color: ThemeColorHelper.primaryRedColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openSignUpBottomSheet(BuildContext context) {
    ThemeBottomSheet.show(
      context,
      key: Key('SignUpBottomSheet'),
      child: SignUpPage(),
    );
  }
}
