part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppLoading extends AppState {}

final class AppSuccess extends AppState {
  final UserEntity userEntity;

  AppSuccess({required this.userEntity});
}

final class AppUserFailed extends AppState {
  final String message;

  AppUserFailed({required this.message});
}
