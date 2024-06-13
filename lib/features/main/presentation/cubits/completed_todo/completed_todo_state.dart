part of 'completed_todo_cubit.dart';

@immutable
sealed class CompletedTodoState {}

final class CompletedTodoInitial extends CompletedTodoState {}

final class CompletedTodoLoading extends CompletedTodoState {}

final class CompletedTodoError extends CompletedTodoState {
  final String message;

  CompletedTodoError(this.message);
}

final class CompletedTodoLoaded extends CompletedTodoState {
  final List<TodoEntity> data;

  CompletedTodoLoaded(this.data);
}
