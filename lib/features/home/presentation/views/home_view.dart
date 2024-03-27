import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/core/utils/show_snackbar.dart';
import 'package:task/features/auth/presentation/views/welcome_view.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFailed) {
            showSnackbar(context: context, content: state.message);
          }
          if (state is HomeLogOut) {
            Navigator.of(context)
                .pushAndRemoveUntil(WelcomeView.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(size.width * 0.1),
            child: Center(
              child: CustomButton(
                size: size,
                backgroundColor: Theme.of(context).colorScheme.primary,
                lable: 'Log Out',
                onPressed: () {
                  context.read<HomeBloc>().add(HomeLogOutEvent());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
