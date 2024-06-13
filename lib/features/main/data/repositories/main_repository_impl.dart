import 'package:clean_arch_example/core/entities/app_error.dart';
import 'package:clean_arch_example/core/usecases/action.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/domain/entities/todo_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:collection/collection.dart';

import '../../domain/repositories/main_repository.dart';
import '../datasources/main_local_data_source.dart';
import '../models/todo_model.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource localDataSource;

  MainRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AppError, void>> deleteDataFromBox(String boxName) async {
    return action(task: localDataSource.deleteDataFromBox(boxName));
  }

  @override
  Future<Either<AppError, void>> deleteTodo(
      TodoEntity entity, String boxName) async {
    return action(
      task: localDataSource.deleteTodo(TodoModel.fromEntity(entity), boxName),
    );
  }

  @override
  Future<Either<AppError, void>> deleteTodos(
      List<TodoEntity> data, String boxName) async {
    final List<TodoModel> listModels =
        data.map((element) => TodoModel.fromEntity(element)).toList();

    return action(task: localDataSource.deleteTodos(listModels, boxName));
  }

  @override
  Future<Either<AppError, List<TodoEntity>>> getListTodo({
    String? boxName,
  }) async {
    return action<List<TodoEntity>>(
      task: localDataSource.getListTodo(boxName: boxName),
    );
  }

  @override
  Future<Either<AppError, void>> save(
    TodoEntity entity, {
    required String boxName,
  }) async {
    final List<TodoModel> listTodo =
        await localDataSource.getListTodo(boxName: boxName);

    if (listTodo.isNotEmpty && boxName != StorageBoxes.completedTodos) {
      final todo =
          listTodo.firstWhereOrNull((element) => element.id == entity.id);
      if (todo != null) {
        return action<void>(
          task: localDataSource.updateTodo(
            TodoModel.fromEntity(entity),
          ),
        );
      }
    }

    return action<void>(
      task:
          localDataSource.save(TodoModel.fromEntity(entity), boxName: boxName),
    );
  }

  @override
  Future<Either<AppError, void>> saveNewList(List<TodoEntity> listTodo) async {
    final listModel =
        listTodo.map((element) => TodoModel.fromEntity(element)).toList();
    return action<void>(task: localDataSource.saveNewList(listModel));
  }

  @override
  Future<Either<AppError, void>> updateTodo(TodoEntity entity) async {
    return action(
        task: localDataSource.updateTodo(TodoModel.fromEntity(entity)));
  }
}
