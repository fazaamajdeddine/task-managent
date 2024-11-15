
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppException, Type>> call(Params params);
}

class NoParams {
  NoParams();
}