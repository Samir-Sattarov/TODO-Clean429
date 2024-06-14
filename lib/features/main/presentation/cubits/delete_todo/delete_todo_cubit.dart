import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo_entity.dart';
import '../../../domain/usecases/todo_usecases.dart';
import '../todo/todo_cubit.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  final DeleteTodoUsecase deleteTodoUsecase;
  DeleteTodoCubit(this.deleteTodoUsecase,) : super(DeleteTodoInitial());

  delete(TodoEntity entity) async {
    emit(DeleteTodoLoading());

    final response = await deleteTodoUsecase
        .call(DeleteTodoUsecaseParams(entity));

    response.fold(
      (l) => emit(DeleteTodoError(l.errorMessage)),
      (r) {
        emit(DeleteTodoSuccess(entity));
      },
    );
  }
}
