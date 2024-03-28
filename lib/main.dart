import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/bloc/bloc/app_bloc.dart';
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
        BlocProvider(create: (context) => serviceLocator<AppBloc>()),
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
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppInitial) {
            context.read<AuthBloc>().add(AuthGetCurrentUserDataEvent());
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AppLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AppSuccess) {
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
