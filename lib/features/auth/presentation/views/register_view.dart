import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/core/utils/show_snackbar.dart';
import 'package:task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:task/features/home/presentation/views/home_view.dart';

class RegisterView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const RegisterView());
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
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
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create a new user account!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Enter your valid details and register in the to task.',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AuthTextField(
                              controller: usernameController,
                              hintText: 'User Name',
                              onFieldSubmitted: (event) {
                                FocusScope.of(context).requestFocus();
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AuthTextField(
                              controller: emailController,
                              focusNode: emailFocus,
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
                              controller: phoneController,
                              focusNode: phoneFocus,
                              hintText: 'Phone',
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
                              obScureText: true,
                              onFieldSubmitted: (event) {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        AuthRegisterEvent(
                                          username:
                                              usernameController.text.trim(),
                                          email: emailController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        ),
                                      );
                                }
                              },
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomButton(
                        size: size,
                        lable: 'REGISTER',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthRegisterEvent(
                                    username: usernameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
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
