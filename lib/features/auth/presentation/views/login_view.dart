import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/core/utils/show_snackbar.dart';
import 'package:task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task/features/auth/presentation/views/forgot_view.dart';
import 'package:task/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:task/features/home/presentation/views/home_view.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showSnackbar(context: context, content: state.message);
          }
          if (state is AuthSuccess) {
            Navigator.of(context)
                .pushAndRemoveUntil(HomeView.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Enter your registered credentials and continue to task.',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthTextField(
                          controller: emailController,
                          hintText: 'Email Address',
                          onFieldSubmitted: (event) {
                            FocusScope.of(context).requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextField(
                          controller: passwordController,
                          focusNode: passwordFocus,
                          hintText: 'Password',
                          textInputAction: TextInputAction.done,
                          obScureText: true,
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthLoginEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(ForgotView.route());
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(letterSpacing: 2.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        size: size,
                        lable: 'LOGIN',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        size: size,
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        lable: 'BACK',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
