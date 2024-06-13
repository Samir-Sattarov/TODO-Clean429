import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/error_flush_bar.dart';
import '../../../../core/utils/success_flash_bar.dart';
import '../../../../core/utils/todo_storage_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../cubits/delete_todo/delete_todo_cubit.dart';
import '../cubits/todo/todo_cubit.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/todo_card_widget.dart';
import 'completed_todo_screen.dart';
import 'create_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<TodoCubit>(context).load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CompletedTodosScreen(),
                ),
              );
            },
            icon: const Icon(Icons.done, color: Colors.white),
          ),
        ],
        title: const Text(
          'Todo list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<DeleteTodoCubit, DeleteTodoState>(
        listener: (context, state) {
          if (state is DeleteTodoError) {
            ErrorFlushBar(state.message).show(context);
          }

          if (state is DeleteTodoSuccess) {
            SuccessFlushBar("Todo успешно удалена ${state.entity.title}")
                .show(context);
            BlocProvider.of<TodoCubit>(context).remove(state.entity);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: controllerSearch,
                onChange: (search) async {
                  BlocProvider.of<TodoCubit>(context).search(search ?? "");
                },
                hintText: "Search",
              ),
              const SizedBox(height: 10),
              BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  print(state);
                  if (state is TodoLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }

                  if (state is TodoError) {
                    return Expanded(child: Center(child: Text(state.message)));
                  }
                  final listTodo =
                      BlocProvider.of<TodoCubit>(context, listen: true)
                          .listTodo;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<TodoCubit>(context).load();
                      },
                      child: ListView.separated(
                        itemCount: listTodo.length,
                        itemBuilder: (context, index) {
                          final todo = listTodo[index];

                          return TodoCardWidget(
                            entity: todo,
                            onDone: () async {
                              BlocProvider.of<SaveTodoCubit>(context).save(
                                todo,
                                boxName: StorageBoxes.completedTodos,
                              );

                              BlocProvider.of<DeleteTodoCubit>(context)
                                  .delete(todo);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}