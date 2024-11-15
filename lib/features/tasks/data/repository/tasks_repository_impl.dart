import 'package:tasks_app/features/tasks/data/datasource/tasks_remote_datasource.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _remoteDataSource;

  TasksRepositoryImpl({
    required TasksRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<AppException, String>> createTask({
    required String title,
    required String description,
    required bool completed,
  }) async {
    return _remoteDataSource.createTask(
      title: title,
      description: description,
      completed: completed,
    );
  }

  @override
  Future<Either<AppException, List<Map<String, dynamic>>>> retrieveTasks() async {
    return _remoteDataSource.retrieveTasks();
  }

  @override
  Future<Either<AppException, void>> updateTask({
    required String taskId,
    required Map<String, dynamic> updates,
  }) async {
    return _remoteDataSource.updateTask(
      taskId: taskId,
      updates: updates,
    );
  }

  @override
  Future<Either<AppException, void>> deleteTask({
    required String taskId,
  }) async {
    return _remoteDataSource.deleteTask(taskId: taskId);
  }
}
