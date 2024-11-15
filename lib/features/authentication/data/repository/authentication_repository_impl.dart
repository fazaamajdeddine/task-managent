
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:tasks_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<AppException, User>> loginUser(
      {required String email, required String password}) async {
    return _remoteDataSource.loginUser(email: email, password: password);
  }

}