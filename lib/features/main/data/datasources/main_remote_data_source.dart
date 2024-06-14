import 'package:clean_arch_example/core/api/api_firebase_client.dart';
import 'package:clean_arch_example/core/api/firebase_collections.dart';

import '../../../../core/utils/todo_storage_service.dart';
import '../models/todo_model.dart';

abstract class MainRemoteDataSource {
  save(TodoModel model);


  Future<List<TodoModel>> getListTodo();


  deleteTodos(List<TodoModel> data);

  deleteTodo(TodoModel entity);

}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  final ApiFirebaseClient _client;

  MainRemoteDataSourceImpl(this._client);

  @override
  deleteTodo(TodoModel entity) async {
    await _client.delete(FirebaseCollections.todos, id: entity.id);
  }

  @override
  deleteTodos(List<TodoModel> data) async {
    final listId = data.map((element) => element.id).toList();
    await _client.deleteListDataFromCollection(
        FirebaseCollections.todos, listId: listId);
  }

  @override
  Future<List<TodoModel>> getListTodo() async {
    final response =
    await _client.getAllDocumentsFromCollection(FirebaseCollections.todos);

    final List<TodoModel> listModel = [];

    for (var el in response) {
      // print(el);
      listModel.add(TodoModel.fromJson(Map<String, dynamic>.from(el)));
    }

    print("listModel $listModel");
    return listModel;
  }

  @override
  save(TodoModel model) async {
    await _client.addToCollection(
      FirebaseCollections.todos,
      json: model.toJson(),
      id: model.id,
    );
  }
}

