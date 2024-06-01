import '../../../../core/utils/todo_storage_service.dart';
import '../../domain/entities/todo_entity.dart';

abstract class MainLocalDataSource {
  save(TodoEntity entity, {String? boxName});

  saveNewList(List<TodoEntity> listTodo);

  Future<List<TodoEntity>> getListTodo({String? boxName});

  Future<void> updateTodo(TodoEntity entity);

  deleteTodos(List<TodoEntity> data, String boxName);

  deleteTodo(TodoEntity entity, String boxName);

  deleteDataFromBox(String boxName);
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  final TodoStorageService todoStorageService;

  MainLocalDataSourceImpl(this.todoStorageService);

  @override
  deleteDataFromBox(String boxName) async {
    await todoStorageService.deleteDataFromBox(boxName);
  }

  @override
  deleteTodo(TodoEntity entity, String boxName) async {
    await todoStorageService.deleteTodo(entity, boxName);
  }

  @override
  deleteTodos(List<TodoEntity> data, String boxName) async {
    await todoStorageService.deleteTodos(data, boxName);
  }

  @override
  Future<List<TodoEntity>> getListTodo({String? boxName}) async {
    final response = await todoStorageService.getListTodo(boxName: boxName);

    return response;
  }

  @override
  save(TodoEntity entity, {String? boxName}) async {
    await todoStorageService.save(entity, boxName: boxName);
  }

  @override
  saveNewList(List<TodoEntity> listTodo) async {
    await todoStorageService.saveNewList(listTodo);
  }

  @override
  Future<void> updateTodo(TodoEntity entity) async {
    await todoStorageService.updateTodo(entity);
  }
}
