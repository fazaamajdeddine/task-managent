import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/authentication/domain/providers/authentication_provider.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_notifier.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_state.dart';
import 'package:tasks_app/features/tasks/domain/providers/tasks_providers.dart';
import 'package:tasks_app/features/tasks/presentation/providers/states/tasks_state.dart';
import 'package:tasks_app/features/tasks/presentation/providers/states/tasks_notifier.dart';

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final addUseCase = ref.read(addUseCaseProvider);
  final deleteUseCase = ref.read(deleteUseCaseProvider);
  final updateUseCase = ref.read(updateUseCaseProvider);
  final retrieveUseCase = ref.read(retrieveUseCaseProvider);
  return TaskNotifier(
      addUseCase, retrieveUseCase, updateUseCase, deleteUseCase);
});
