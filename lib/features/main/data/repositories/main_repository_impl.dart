import 'package:clean_arch_example/core/entities/app_error.dart';
import 'package:clean_arch_example/core/usecases/action.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_remote_data_source.dart';
import 'package:clean_arch_example/features/main/domain/entities/todo_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:collection/collection.dart';

import '../../domain/repositories/main_repository.dart';
import '../datasources/main_local_data_source.dart';
import '../models/todo_model.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource localDataSource;
  final MainRemoteDataSource remoteDataSource;

  MainRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<AppError, void>> deleteTodo(
      TodoEntity entity) async {
    return action(
      task: remoteDataSource.deleteTodo(TodoModel.fromEntity(entity)),
    );
  }

  @override
  Future<Either<AppError, void>> deleteTodos(
      List<TodoEntity> data) async {
    final List<TodoModel> listModels =
        data.map((element) => TodoModel.fromEntity(element)).toList();

    return action(task: remoteDataSource.deleteTodos(listModels));
  }

  @override
  Future<Either<AppError, List<TodoEntity>>> getListTodo() async {
    return action<List<TodoEntity>>(
      task: remoteDataSource.getListTodo(),
    );
  }

  @override
  Future<Either<AppError, void>> save(
    TodoEntity entity) async {
    return action<void>(
      task: remoteDataSource.save(TodoModel.fromEntity(entity)),
    );
  }


}
