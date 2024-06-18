import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';

abstract class AuthRepository {
  Future<Either<AppError, void>> signIn(String email, String password);
  Future<Either<AppError, void>> signUp(String email, String password);
}
