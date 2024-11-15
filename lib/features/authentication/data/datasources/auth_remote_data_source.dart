import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

abstract class AuthDataSource {
  Future<Either<AppException, User>> loginUser(
      {required String email, required String password});
}

class AuthRemoteDataSource implements AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<AppException, User>> loginUser(
      {required String email, required String password}) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      if (user == null) {
        return Left(AppException(
            message: "User not found",
            statusCode: 404,
            identifier: "AuthRemoteDataSource.loginUser"));
      }

      return Right(user);
    } catch (e) {
      return Left(
        AppException(
          //e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
