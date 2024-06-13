import '../../../../core/utils/todo_storage_service.dart';
import '../models/todo_model.dart';

abstract class MainLocalDataSource {
  save(TodoModel entity, {String? boxName});

  saveNewList(List<TodoModel> listTodo);

  Future<List<TodoModel>> getListTodo({String? boxName});

  Future<void> updateTodo(TodoModel entity);

  deleteTodos(List<TodoModel> data, String boxName);

  deleteTodo(TodoModel entity, String boxName);

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
  deleteTodo(TodoModel entity, String boxName) async {
    await todoStorageService.deleteTodo(entity, boxName);
  }

  @override
  deleteTodos(List<TodoModel> data, String boxName) async {
    await todoStorageService.deleteTodos(data, boxName);
  }

  @override
  Future<List<TodoModel>> getListTodo({String? boxName}) async {
    final response = await todoStorageService.getListTodo(boxName: boxName);

    return response;
  }

  @override
  save(TodoModel entity, {String? boxName}) async {
    await todoStorageService.save(entity, boxName: boxName);
  }

  @override
  saveNewList(List<TodoModel> listTodo) async {
    await todoStorageService.saveNewList(listTodo);
  }

  @override
  Future<void> updateTodo(TodoModel entity) async {
    await todoStorageService.updateTodo(entity);
  }
}
