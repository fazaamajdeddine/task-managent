

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

import '../../../../shared/use_case.dart';

class LoginUseCases implements UseCase<User, Params> {
  final AuthenticationRepository authRepository;

  LoginUseCases(this.authRepository);

  @override
  Future<Either<AppException, User>> call(Params params) async {
    return await authRepository.loginUser(
        email: params.usermail, password: params.password);
  }
}

class Params<T> {
  final String usermail;
  final String password;
  Params({required this.usermail, required this.password});
}