import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

import '../../../../shared/use_case.dart';

class UpdateTaskUseCase implements UseCase<void, UpdateTaskParams> {
  final TasksRepository tasksRepository;

  UpdateTaskUseCase(this.tasksRepository);

  @override
  Future<Either<AppException, void>> call(UpdateTaskParams params) async {
    return await tasksRepository.updateTask(
      taskId: params.taskId,
      updates: params.updates,
    );
  }
}

class UpdateTaskParams {
  final String taskId;
  final Map<String, dynamic> updates;

  UpdateTaskParams({
    required this.taskId,
    required this.updates,
  });
}
