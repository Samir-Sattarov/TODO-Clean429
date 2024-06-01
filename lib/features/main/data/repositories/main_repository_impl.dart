
import 'dart:io';

import 'package:clean_arch_example/features/main/domain/entities/todo_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../domain/repositories/main_repository.dart';
import '../datasources/main_local_data_source.dart';

class MainRepositoryImpl implements MainRepository {

  final MainLocalDataSource mainLocalDataSource;

  MainRepositoryImpl(this.mainLocalDataSource);


  @override
  deleteDataFromBox(String boxName)async  {

  }

  @override
  deleteTodo(TodoEntity entity, String boxName) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  deleteTodos(List<TodoEntity> data, String boxName) {
    // TODO: implement deleteTodos
    throw UnimplementedError();
  }

  @override
  Future<List<TodoEntity>> getListTodo({String? boxName}) {
    // TODO: implement getListTodo
    throw UnimplementedError();
  }

  @override
  save(TodoEntity entity, {String? boxName}) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  saveNewList(List<TodoEntity> listTodo) {
    // TODO: implement saveNewList
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoEntity entity) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}