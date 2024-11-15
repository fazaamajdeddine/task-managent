import 'package:equatable/equatable.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/response.dart';

class AppException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }

  // Factory method to create an AppException from any error
  factory AppException.from(dynamic error) {
    return AppException(
      message: error.toString(),
      statusCode: 500,
      identifier: 'Unknown Exception',
    );
  }
}

class CacheFailureException extends Equatable implements AppException {
  @override
  String get identifier => 'Cache failure exception';

  @override
  String get message => 'Unable to save user';

  @override
  int get statusCode => 100;

  @override
  List<Object?> get props => [message, statusCode, identifier];
}

// Extension
extension HttpExceptionExtension on AppException {
  Left<AppException, Response> get toLeft => Left<AppException, Response>(this);
}
