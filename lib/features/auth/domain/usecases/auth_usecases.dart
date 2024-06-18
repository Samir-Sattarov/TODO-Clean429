import 'package:clean_arch_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecases/usecase.dart';

class SignInUsecase extends UseCase<void, AuthUsecaseParams> {
  final AuthRepository repository;

  SignInUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(AuthUsecaseParams params) {
    return repository.signIn(
      params.email,
      params.password,
    );
  }
}

class SignUpUsecase extends UseCase<void, AuthUsecaseParams> {
  final AuthRepository repository;

  SignUpUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(AuthUsecaseParams params) {
    return repository.signUp(
      params.email,
      params.password,
    );
  }
}

class AuthUsecaseParams {
  final String email;
  final String password;

  AuthUsecaseParams(this.email, this.password);
}
