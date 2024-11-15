import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

import '../../../../shared/use_case.dart';

class RetrieveTasksUseCase implements UseCase<List<Map<String, dynamic>>, NoParams> {
  final TasksRepository tasksRepository;

  RetrieveTasksUseCase(this.tasksRepository);

  @override
  Future<Either<AppException, List<Map<String, dynamic>>>> call(NoParams params) async {
    return await tasksRepository.retrieveTasks();
  }
}

