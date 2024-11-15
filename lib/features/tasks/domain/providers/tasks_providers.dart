import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:tasks_app/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:tasks_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasks_app/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:tasks_app/features/tasks/data/datasource/tasks_remote_datasource.dart';
import 'package:tasks_app/features/tasks/data/repository/tasks_repository_impl.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/retrieve_tasks_use_case.dart';
import 'package:tasks_app/features/tasks/domain/usecases/update_task_use_case.dart';

final taskRemoteDataSourceProvider = Provider<TasksRemoteDataSource>((ref) {
  return TasksRemoteDataSource();
});


final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  final tasksRemoteDataSource = ref.watch(taskRemoteDataSourceProvider);
  return TasksRepositoryImpl(remoteDataSource: tasksRemoteDataSource);
});


final addUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  return CreateTaskUseCase(ref.read(tasksRepositoryProvider));
});

final deleteUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  return DeleteTaskUseCase(ref.read(tasksRepositoryProvider));
});


final updateUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  return UpdateTaskUseCase(ref.read(tasksRepositoryProvider));
});


final retrieveUseCaseProvider = Provider<RetrieveTasksUseCase>((ref) {
  return RetrieveTasksUseCase(ref.read(tasksRepositoryProvider));
});
