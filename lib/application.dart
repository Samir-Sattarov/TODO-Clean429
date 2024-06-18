import 'package:clean_arch_example/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';
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
  late SignUpCubit signUpCubit;
  late SignInCubit signInCubit;

  @override
  void initState() {
    counterCubit = locator();
    todoCubit = locator();
    completedTodoCubit = locator();
    saveTodoCubit = locator();
    deleteTodoCubit = locator();
    signInCubit = locator();
    signUpCubit = locator();
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
        BlocProvider.value(value: signInCubit),
        BlocProvider.value(value: signUpCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        home: const SignUpScreen(),
      ),
    );
  }
}
