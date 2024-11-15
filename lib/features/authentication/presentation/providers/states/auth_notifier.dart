
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:tasks_app/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:tasks_app/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_state.dart';


class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCases _authUseCases;

  AuthNotifier(
    this._authUseCases,
  ) : super(const AuthState.initial(),) {}

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await _authUseCases
        .call(Params(usermail: email, password: password));
    result.fold(
      (failure) => state = AuthState.failure(failure),
      (user) {
        state = AuthState.authenticated(user: user);
      },
    );
  }



  void logout() {
    GetIt.instance.get<AuthLocalDataSource>().logout();
    state = const AuthState.initial();
  }
}