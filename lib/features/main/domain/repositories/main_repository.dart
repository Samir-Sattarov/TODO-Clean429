import '../entities/todo_entity.dart';

abstract class MainRepository {
  save(TodoEntity entity, {String? boxName});

  saveNewList(List<TodoEntity> listTodo);

  Future<List<TodoEntity>> getListTodo({String? boxName});

  Future<void> updateTodo(TodoEntity entity);

  deleteTodos(List<TodoEntity> data, String boxName);

  deleteTodo(TodoEntity entity, String boxName);

  deleteDataFromBox(String boxName);
}
