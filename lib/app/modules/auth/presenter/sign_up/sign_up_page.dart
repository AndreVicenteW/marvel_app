import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/presenter/sign_up/sign_up_bloc.dart';
import 'package:validatorless/validatorless.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final SignUpBloc _signUpBloc = Modular.get();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: ThemeColorHelper.primarySilverColor,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThemeText(text: 'Create your account'),
              SizedBox(
                height: 20,
              ),
              ThemeInput(
                controller: _nameController,
                placeholder: 'Name',
                icon: Icons.person_outline,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: Validatorless.multiple(
                    [Validatorless.required('Required field')]),
              ),
              SizedBox(
                height: 20,
              ),
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
                textInputAction: TextInputAction.done,
                password: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Required field'),
                  Validatorless.min(3, 'Minimum 3 digits')
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer(
                bloc: _signUpBloc,
                listener: (context, state) {
                  if (state is SuccessState) {
                    Modular.to.pushReplacementNamed('/home/');
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state is ErrorState)
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
                      ThemeButton(
                        text: 'Sign Up',
                        loading: state is LoadingState,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUpBloc.call(
                              UserEntity(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
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
    );
  }
}
