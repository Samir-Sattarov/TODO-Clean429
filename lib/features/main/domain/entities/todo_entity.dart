class TodoEntity {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
  });

  factory TodoEntity.empty() {
    return TodoEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "",
      description: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isDone: false,
    );
  }

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isDone,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
      updatedAt: DateTime.now(),
    );
  }

  @override
  String toString() => """
    id : $id
    title : $title
    description : $description
    createdAt : $createdAt
    isDone : $isDone
    """;
}
