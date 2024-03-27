import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/entity/user_entity.dart';
import 'package:task/features/auth/presentation/views/welcome_view.dart';
import 'package:task/features/home/features/profile/presentation/profile_view.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';

class HomeView extends StatefulWidget {
  static route(UserEntity userEntity) => MaterialPageRoute(
      builder: (context) => HomeView(
            userEntity: userEntity,
          ));
  const HomeView({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
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
          return views.elementAt(currentIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            currentIndex = state.currentIndex;
          }
          if (state is HomeSuccess) {
            currentIndex = state.currentIndex;
          }
          return BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: currentIndex,
            onTap: (value) {
              context
                  .read<HomeBloc>()
                  .add(HomeCurrentIndexEvent(currentIndex: value));
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Person'),
            ],
          );
        },
      ),
    );
  }
}

List<Widget> views = const [
  Center(
    child: Text('DashBoard'),
  ),
  Center(
    child: Text('Add Call'),
  ),
  ProfileView(),
];
