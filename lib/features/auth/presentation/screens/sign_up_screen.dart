import 'package:clean_arch_example/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:clean_arch_example/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:clean_arch_example/features/main/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/presentation/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
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
                  "Sign up",
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
                    BlocProvider.of<SignUpCubit>(context)
                        .signUp(controllerEmail.text, controllerPassword.text);
                  },
                  child: const Center(
                    child: Text("Sign up"),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ));
                    },
                    child: Text(
                      "Sign in ",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
