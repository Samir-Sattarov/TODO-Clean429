import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/main_repository.dart';

class GetListTodoUsecase extends UseCase<List<TodoEntity>, NoParams> {
  final MainRepository repository;

  GetListTodoUsecase(this.repository);

  @override
  Future<Either<AppError, List<TodoEntity>>> call(NoParams params) =>
      repository.getListTodo();
}

class SaveTodoUsecase extends UseCase<void, SaveTodoUsecaseParams> {
  final MainRepository repository;

  SaveTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(SaveTodoUsecaseParams params) {
    return repository.save(params.entity);
  }
}

class DeleteTodoUsecase extends UseCase<void, DeleteTodoUsecaseParams> {
  final MainRepository repository;

  DeleteTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteTodoUsecaseParams params) {
    return repository.deleteTodo(
      params.entity,
    );
  }
}

class DeleteListTodoUsecase extends UseCase<void, DeleteListTodoUsecaseParams> {
  final MainRepository repository;

  DeleteListTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteListTodoUsecaseParams params) {
    return repository.deleteTodos(params.data);
  }
}

// ================ Params ================ //

class DeleteListTodoUsecaseParams {
  final List<TodoEntity> data;

  DeleteListTodoUsecaseParams(this.data);
}

class GetListTodoUsecaseParams {}

class SaveTodoUsecaseParams {
  final TodoEntity entity;
  SaveTodoUsecaseParams(this.entity);
}

class DeleteTodoUsecaseParams {
  final TodoEntity entity;

  DeleteTodoUsecaseParams(this.entity);
}
