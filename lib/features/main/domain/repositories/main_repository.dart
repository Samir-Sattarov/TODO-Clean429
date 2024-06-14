import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../entities/todo_entity.dart';

abstract class MainRepository {
  Future<Either<AppError, void>> save(TodoEntity entity);

  Future<Either<AppError, List<TodoEntity>>> getListTodo();

  Future<Either<AppError, void>> deleteTodos(
      List<TodoEntity> data, String boxName);

  Future<Either<AppError, void>> deleteTodo(TodoEntity entity);

  Future<Either<AppError, void>> deleteDataFromBox(String boxName);
}
