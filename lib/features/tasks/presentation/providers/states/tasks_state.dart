import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

part 'tasks_state.freezed.dart';

@freezed
abstract class TaskState with _$TaskState {
  // Create Task States
  const factory TaskState.createInitial() = CreateInitial;
  const factory TaskState.createLoading() = CreateLoading;
  const factory TaskState.taskCreated({required String task}) = TaskCreated;
  const factory TaskState.createFailure(AppException exception) = CreateFailure;
  const factory TaskState.createSuccess() = CreateSuccess;

  // Retrieve Tasks States
  const factory TaskState.retrieveInitial() = RetrieveInitial;
  const factory TaskState.retrieveLoading() = RetrieveLoading;
  const factory TaskState.tasksRetrieved({required List<Map<String, dynamic>> tasks}) = TasksRetrieved;
  const factory TaskState.retrieveFailure(AppException exception) = RetrieveFailure;

  // Update Task States
  const factory TaskState.updateInitial() = UpdateInitial;
  const factory TaskState.updateLoading() = UpdateLoading;
  const factory TaskState.taskUpdated() = TaskUpdated;
  const factory TaskState.updateFailure(AppException exception) = UpdateFailure;

  // Delete Task States
  const factory TaskState.deleteInitial() = DeleteInitial;
  const factory TaskState.deleteLoading() = DeleteLoading;
  const factory TaskState.taskDeleted() = TaskDeleted;
  const factory TaskState.deleteFailure(AppException exception) = DeleteFailure;
}
