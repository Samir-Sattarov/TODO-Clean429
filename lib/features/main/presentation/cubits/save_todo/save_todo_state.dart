part of 'save_todo_cubit.dart';

@immutable
sealed class SaveTodoState {}

final class SaveTodoInitial extends SaveTodoState {}
final class SaveTodoLoading extends SaveTodoState {}
final class SaveTodoError extends SaveTodoState {
  final String message;

  SaveTodoError(this.message);
}


final class SaveTodoSaved extends SaveTodoState {}
