import 'package:clean_arch_example/features/main/presentation/screens/home_screen.dart';
import 'package:clean_arch_example/features/main/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/sign_in/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 100),
                TextFormFieldWidget(
                  controller: controllerEmail,
                  hintText: "email",
                ),
                const SizedBox(height: 15),
                TextFormFieldWidget(
                  controller: controllerPassword,
                  hintText: "password",
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SignInCubit>(context).signIn(
                      controllerEmail.text,
                      controllerPassword.text,
                    );
                  },
                  child: const Center(
                    child: Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "back",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
