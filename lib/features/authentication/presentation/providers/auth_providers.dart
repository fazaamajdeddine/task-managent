
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/authentication/domain/providers/authentication_provider.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_notifier.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_state.dart';


final loginNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return AuthNotifier(loginUseCase);
});

