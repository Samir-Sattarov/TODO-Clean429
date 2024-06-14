import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo_entity.dart';
import '../../../domain/usecases/todo_usecases.dart';

part 'save_todo_state.dart';

class SaveTodoCubit extends Cubit<SaveTodoState> {
  final SaveTodoUsecase saveTodoUsecase;
  SaveTodoCubit(this.saveTodoUsecase) : super(SaveTodoInitial());

  save(TodoEntity entity) async {
    emit(SaveTodoLoading());

    final response = await saveTodoUsecase.call(SaveTodoUsecaseParams(entity));

    response.fold(
      (l) => emit(SaveTodoError(l.errorMessage)),
      (r) => emit(SaveTodoSaved()),
    );

  }
}
