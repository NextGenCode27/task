import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/global/bloc/bloc/app_bloc.dart';
import 'package:task/core/global/cubit/app_user_cubit/app_user_cubit.dart';
import 'package:task/core/secrets/supabase_secrets.dart';
import 'package:task/features/auth/data/data_source/remote/auth_remote_datasource.dart';
import 'package:task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';
import 'package:task/features/auth/domain/usecase/current_user_usecase.dart';
import 'package:task/features/auth/domain/usecase/forgot_usecase.dart';
import 'package:task/features/auth/domain/usecase/login_usecase.dart';
import 'package:task/features/auth/domain/usecase/register_usecase.dart';
import 'package:task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task/features/home/data/data_source/remote/home_remote_datasource.dart';
import 'package:task/features/home/data/repository/home_repository_impl.dart';
import 'package:task/features/home/domain/domain/home_repository.dart';
import 'package:task/features/home/domain/usecase/log_out_usecase.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();
  final Supabase supabase = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  serviceLocator.registerLazySingleton<AppBloc>(() => AppBloc());
}

_initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<LoginUsecase>(
      () => LoginUsecase(serviceLocator()),
    )
    ..registerFactory<RegisterUsecase>(
      () => RegisterUsecase(serviceLocator()),
    )
    ..registerFactory<ForgotUsecase>(
      () => ForgotUsecase(serviceLocator()),
    )
    ..registerFactory<CurrentUserUsecase>(
      () => CurrentUserUsecase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        loginUsecase: serviceLocator(),
        registerUsecase: serviceLocator(),
        forgotUsecase: serviceLocator(),
        currentUserUsecase: serviceLocator(),
        appBloc: serviceLocator(),
      ),
    );
}

_initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImp(serviceLocator()),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<LogOutUsecase>(
      () => LogOutUsecase(serviceLocator()),
    )
    ..registerLazySingleton<HomeBloc>(
      () => HomeBloc(logOutUsecase: serviceLocator()),
    );
}
