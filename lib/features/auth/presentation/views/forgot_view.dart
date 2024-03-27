import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/core/utils/show_snackbar.dart';
import 'package:task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:task/features/home/presentation/views/home_view.dart';

class ForgotView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const ForgotView());
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
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
          if (state is AuthForgotSuccess) {
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
                          'Forgot your password!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Enter your registered email address and we will send you password reset link.',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        AuthTextField(
                          controller: emailController,
                          hintText: 'Email Address',
                          onFieldSubmitted: (event) {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthForgotEvent(
                                      email: emailController.text.trim(),
                                    ),
                                  );
                            }
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        size: size,
                        lable: 'SEND EMAIL',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthForgotEvent(
                                    email: emailController.text.trim(),
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
