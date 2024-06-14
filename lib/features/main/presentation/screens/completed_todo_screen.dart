import 'package:clean_arch_example/core/utils/todo_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/error_flush_bar.dart';
import '../../domain/entities/todo_entity.dart';
import '../cubits/completed_todo/completed_todo_cubit.dart';
import '../widgets/todo_card_widget.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
 late  List<TodoEntity> listTodo;
  @override
  void initState() {



    listTodo = [];
    BlocProvider.of<CompletedTodoCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<CompletedTodoCubit>(context).clear(listTodo);
            },
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
        ],
        title: const Text(
          'Completed Todo list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<CompletedTodoCubit, CompletedTodoState>(
        listener: (context, state) {
          if (state is CompletedTodoError) {
            ErrorFlushBar(state.message).show(context);
          }
          if (state is CompletedTodoLoaded) {
            listTodo = state.data;

            print("Completed todo ${listTodo.length}");

          }
        },
        builder: (context, state) {
          if (state is CompletedTodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompletedTodoError) {
            return Center(child: Text(state.message));
          }



          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<CompletedTodoCubit>(context).load();
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.separated(
                itemCount: listTodo.length,
                itemBuilder: (context, index) {
                  final todo = listTodo[index].copyWith(isDone: true);

                  return AbsorbPointer(
                    child: TodoCardWidget(
                      entity: todo,
                      isMenuActive: false,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
              ),
            ),
          );

          return const SizedBox();
        },
      ),
    );
  }
}
