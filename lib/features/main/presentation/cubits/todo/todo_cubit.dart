import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/entities/app_error.dart';
import 'package:clean_arch_example/core/entities/no_params.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_local_data_source.dart';
import 'package:clean_arch_example/features/main/data/repositories/main_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo_entity.dart';
import '../../../domain/usecases/todo_usecases.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetListTodoUsecase getListTodoUsecase;
  TodoCubit(this.getListTodoUsecase) : super(TodoInitial());

  List<TodoEntity> listTodo = [];

  remove(TodoEntity todo) {
    listTodo.remove(todo);

    emit(TodoLoaded(listTodo));
  }

  load() async {
    emit(TodoLoading());

    final response = await getListTodoUsecase.call(NoParams());

    response.fold(
      (l) => emit(TodoError(l.errorMessage)),
      (r) {
        listTodo.clear();
        final List<TodoEntity> formatted = r;

        formatted.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );

        listTodo =
            formatted.where((element) => element.isDone == false).toList();
        emit(TodoLoaded(listTodo));
      },
    );
  }

  search(String? value) {
    if (value == null || value.isEmpty) {
      load();
    }
    final List<TodoEntity> data = listTodo.where(
      (element) {
        return element.title.toLowerCase().contains(value!.toLowerCase());
      },
    ).toList();
    listTodo = data;
    emit(TodoLoaded(listTodo));
  }
}
