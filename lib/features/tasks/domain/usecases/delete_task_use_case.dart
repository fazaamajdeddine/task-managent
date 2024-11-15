import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

import '../../../../shared/use_case.dart';

class DeleteTaskUseCase implements UseCase<void, DeleteTaskParams> {
  final TasksRepository tasksRepository;

  DeleteTaskUseCase(this.tasksRepository);

  @override
  Future<Either<AppException, void>> call(DeleteTaskParams params) async {
    return await tasksRepository.deleteTask(taskId: params.taskId);
  }
}

class DeleteTaskParams {
  final String taskId;

  DeleteTaskParams({required this.taskId});
}
