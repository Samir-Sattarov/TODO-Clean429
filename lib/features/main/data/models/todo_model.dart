import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
    required super.isDone,
  });

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isDone: entity.isDone,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    data['isDone'] = isDone;

    return data;
  }
}
