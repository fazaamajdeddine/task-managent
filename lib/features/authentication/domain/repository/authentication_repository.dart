import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
 Future<Either<AppException, User>> loginUser(
      {required String email, required String password});
}
