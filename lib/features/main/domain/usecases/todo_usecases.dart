import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_entity.dart';
import '../repositories/main_repository.dart';

class GetListTodoUsecase
    extends UseCase<List<TodoEntity>, GetListTodoUsecaseParams> {
  final MainRepository repository;

  GetListTodoUsecase(this.repository);

  @override
  Future<Either<AppError, List<TodoEntity>>> call(
          GetListTodoUsecaseParams params) =>
      repository.getListTodo(boxName: params.boxName);
}

class SaveTodoUsecase extends UseCase<void, SaveTodoUsecaseParams> {
  final MainRepository repository;

  SaveTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(SaveTodoUsecaseParams params) {
    return repository.save(params.entity,boxName: params.boxName);
  }
}

class DeleteTodoUsecase extends UseCase<void, DeleteTodoUsecaseParams> {
  final MainRepository repository;

  DeleteTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteTodoUsecaseParams params) {
    return repository.deleteTodo(
      params.entity,
      params.boxName,
    );
  }
}

class ClearCompletedTodoUsecase extends UseCase<void, NoParams> {
  final MainRepository repository;

  ClearCompletedTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) {
    return repository.deleteDataFromBox(StorageBoxes.completedTodos);
  }
}

// ================ Params ================ //

class GetListTodoUsecaseParams {
  final String boxName;

  GetListTodoUsecaseParams(this.boxName);
}

class SaveTodoUsecaseParams {
  final TodoEntity entity;
  final String boxName;
  SaveTodoUsecaseParams(this.entity, this.boxName);
}

class DeleteTodoUsecaseParams {
  final TodoEntity entity;
  final String boxName;

  DeleteTodoUsecaseParams(this.entity, this.boxName);
}
