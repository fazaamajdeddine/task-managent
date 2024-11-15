import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/retrieve_tasks_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:tasks_app/features/tasks/presentation/providers/states/tasks_state.dart';
import 'package:tasks_app/shared/use_case.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final CreateTaskUseCase _createTaskUseCase;
  final RetrieveTasksUseCase _retrieveTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskNotifier(
    this._createTaskUseCase,
    this._retrieveTasksUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const TaskState.createInitial());

  // Create Task
  Future<void> createTask(String title, String description) async {
    state = const TaskState.createLoading();
    final result = await _createTaskUseCase.call(CreateTaskParams(
      title: title,
      description: description,
      completed: false,
    ));
    retrieveTasks();

    result.fold(
      (failure) => state = TaskState.createFailure(failure),
      (task) => state = TaskState.taskCreated(task: task),
    );
  }

  // Retrieve Tasks
  Future<void> retrieveTasks() async {
    state = const TaskState.retrieveLoading();
    final result = await _retrieveTasksUseCase.call(NoParams());
    result.fold(
      (failure) => state = TaskState.retrieveFailure(failure),
      (tasks) => state = TaskState.tasksRetrieved(tasks: tasks),
    );
  }

  // Update Task
  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    state = const TaskState.updateLoading();
    final result = await _updateTaskUseCase.call(UpdateTaskParams(
      taskId: taskId,
      updates: updates,
    ));
    retrieveTasks();
    result.fold(
      (failure) => state = TaskState.updateFailure(failure),
      (_) => state = const TaskState.taskUpdated(),
    );
  }

  // Delete Task
  Future<void> deleteTask(String taskId) async {
    state = const TaskState.deleteLoading();
    final result =
        await _deleteTaskUseCase.call(DeleteTaskParams(taskId: taskId));
    retrieveTasks();

    result.fold(
      (failure) => state = TaskState.deleteFailure(failure),
      (_) => state = const TaskState.taskDeleted(),
    );
  }
}
