import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

abstract class TasksRepository {
  Future<Either<AppException, String>> createTask({
    required String title,
    required String description,
    required bool completed,
  });

  Future<Either<AppException, List<Map<String, dynamic>>>> retrieveTasks();

  Future<Either<AppException, void>> updateTask({
    required String taskId,
    required Map<String, dynamic> updates,
  });

  Future<Either<AppException, void>> deleteTask({
    required String taskId,
  });
}
