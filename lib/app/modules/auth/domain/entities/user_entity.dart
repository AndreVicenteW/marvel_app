import 'package:string_validator/string_validator.dart' as validator;

class UserEntity {
  final String? id;
  final String? name;
  final String email;
  final String? password;

  UserEntity({
    required this.email,
    this.id = '',
    this.password = '',
    this.name = '',
  });

  bool get isValidEmail => validator.isEmail(email);

  bool get isValidPassword =>
      password != null && password!.isNotEmpty && password!.length > 2;
}
