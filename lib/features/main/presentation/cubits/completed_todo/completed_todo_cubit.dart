import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/entities/no_params.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo_entity.dart';
import '../../../domain/usecases/todo_usecases.dart';

part 'completed_todo_state.dart';

class CompletedTodoCubit extends Cubit<CompletedTodoState> {
  final GetListTodoUsecase getListTodoUsecase;
  final DeleteListTodoUsecase deleteListTodoUsecase;
  CompletedTodoCubit(this.getListTodoUsecase, this.deleteListTodoUsecase) : super(CompletedTodoInitial());

  load() async {
    emit(CompletedTodoLoading());

    final response = await getListTodoUsecase
        .call(NoParams());

    response.fold(
      (l) => emit(CompletedTodoError(l.errorMessage)),
      (r) {

        final formattedList = r.where((element) => element.isDone == true).toList();
        emit(CompletedTodoLoaded(formattedList));
      },
    );
  }

  clear(List<TodoEntity> listTodo) async {
    emit(CompletedTodoLoading());

    final response = await deleteListTodoUsecase.call(DeleteListTodoUsecaseParams(listTodo));

    response.fold(
          (l) => emit(CompletedTodoError(l.errorMessage)),
          (r) => emit(CompletedTodoLoaded([])),
    );

  }
}
