import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:tasks_app/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:tasks_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasks_app/features/authentication/domain/usecases/auth_use_case.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});


final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final authRemoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthenticationRepositoryImpl(remoteDataSource: authRemoteDataSource);
});


final loginUseCaseProvider = Provider<LoginUseCases>((ref) {
  return LoginUseCases(ref.read(authenticationRepositoryProvider));
});
