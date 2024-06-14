import 'package:clean_arch_example/core/utils/error_flush_bar.dart';
import 'package:clean_arch_example/core/utils/success_flash_bar.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entity.dart';
import '../cubits/todo/todo_cubit.dart';
import '../widgets/text_form_field_widget.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoEntity entity;
  const EditTodoScreen({super.key, required this.entity});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  TodoEntity entity = TodoEntity.empty();

  @override
  void initState() {
    entity = widget.entity;
    controllerTitle.text = entity.title;
    controllerDescription.text = entity.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text(
          'Edit Todo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<SaveTodoCubit, SaveTodoState>(
        listener: (_, state) {
          if (state is SaveTodoError) {
            ErrorFlushBar(state.message).show(context);
          }

          if (state is SaveTodoSaved) {
            SuccessFlushBar("Todo успешно изменена").show(context);
            BlocProvider.of<TodoCubit>(context).load();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormFieldWidget(
                controller: controllerTitle,
                hintText: "Title",
                onChange: (value) {
                  entity = entity.copyWith(title: value);
                },
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                controller: controllerDescription,
                hintText: "Descriptions",
                onChange: (value) {
                  entity = entity.copyWith(description: value);
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<SaveTodoCubit, SaveTodoState>(
                builder: (_, state) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: state is SaveTodoSaved
                              ? Colors.green
                              : Colors.blueGrey),
                      onPressed: () {
                        BlocProvider.of<SaveTodoCubit>(context).save(entity);
                      },
                      child: const Text(
                        "Обновить",
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
