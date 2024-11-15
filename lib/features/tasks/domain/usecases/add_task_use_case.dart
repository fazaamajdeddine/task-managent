import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

import '../../../../shared/use_case.dart';

class CreateTaskUseCase implements UseCase<String, CreateTaskParams> {
  final TasksRepository tasksRepository;

  CreateTaskUseCase(this.tasksRepository);

  @override
  Future<Either<AppException, String>> call(CreateTaskParams params) async {
    return await tasksRepository.createTask(
      title: params.title,
      description: params.description,
      completed: params.completed,
    );
  }
}

class CreateTaskParams {
  final String title;
  final String description;
  final bool completed;

  CreateTaskParams({
    required this.title,
    required this.description,
    required this.completed,
  });
}
