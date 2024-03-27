import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:task/core/themes/light_theme.dart';
import 'package:task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task/features/auth/presentation/views/welcome_view.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';
import 'package:task/features/home/presentation/views/home_view.dart';
import 'package:task/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (context) => serviceLocator<HomeBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetCurrentUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: ThemeData.dark(),
      // home: BlocSelector<AppUserCubit, AppUserState, bool>(
      //   selector: (state) {
      //     return state is AppUserLoggedIn;
      //   },
      //   builder: (context, state) {
      //     if (state) {
      //       return const HomeView();
      //     } else {
      //       return const LoginView();
      //     }
      //   },
      // ),
      home: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return HomeView(
              userEntity: state.userEntity,
            );
          } else {
            return const WelcomeView();
          }
        },
      ),
    );
  }
}
