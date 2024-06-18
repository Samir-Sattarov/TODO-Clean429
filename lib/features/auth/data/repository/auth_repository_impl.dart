import 'package:clean_arch_example/core/usecases/action.dart';
import 'package:clean_arch_example/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:clean_arch_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, void>> signIn(String email, String password) async {
    return action(task: remoteDataSource.signIn(email, password));
  }

  @override
  Future<Either<AppError, void>> signUp(String email, String password) {
    return action(task: remoteDataSource.signUp(email, password));
  }
}
