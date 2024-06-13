part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}

final class TodoLoaded extends TodoState {
  final List<TodoEntity> listTodo;

  TodoLoaded(this.listTodo);
}
