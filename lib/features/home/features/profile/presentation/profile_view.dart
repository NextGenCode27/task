import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/bloc/bloc/app_bloc.dart';
import 'package:task/core/global/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        actions: [
          IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(HomeLogOutEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  if (state is AppSuccess) {
                    return ProfileContainer(
                      size: size,
                      username: state.userEntity.username,
                      email: state.userEntity.email,
                      avatarUrl: state.userEntity.avatarUrl,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.size,
    required this.username,
    required this.email,
    required this.avatarUrl,
  });

  final Size size;
  final String username;
  final String email;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.7,
      width: size.width,
      padding: EdgeInsets.all(size.width * 0.1),
      color: Theme.of(context).colorScheme.onBackground,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
