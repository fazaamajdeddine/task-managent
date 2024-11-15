
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticated({required User user}) = Authenticated;
  const factory AuthState.failure(AppException exception) = Failure;
  const factory AuthState.success() = Success;
}