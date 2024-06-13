import 'package:clean_arch_example/features/main/presentation/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/main/presentation/cubits/completed_todo/completed_todo_cubit.dart';
import 'features/main/presentation/cubits/delete_todo/delete_todo_cubit.dart';
import 'features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'features/main/presentation/cubits/todo/todo_cubit.dart';
import 'features/main/presentation/screens/counter_screen.dart';
import 'features/main/presentation/screens/home_screen.dart';
import 'locator.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late CounterCubit counterCubit;
  late CompletedTodoCubit completedTodoCubit;
  late TodoCubit todoCubit;
  late SaveTodoCubit saveTodoCubit;
  late DeleteTodoCubit deleteTodoCubit;

  @override
  void initState() {
    counterCubit = locator();
    todoCubit = locator();
    completedTodoCubit = locator();
    saveTodoCubit = locator();
    deleteTodoCubit = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: counterCubit),
        BlocProvider.value(value: todoCubit),
        BlocProvider.value(value: completedTodoCubit),
        BlocProvider.value(value: saveTodoCubit),
        BlocProvider.value(value: deleteTodoCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        home: const HomeScreen(),
      ),
    );
  }
}
