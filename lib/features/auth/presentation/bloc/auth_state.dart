part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity userEntity;
  AuthSuccess({required this.userEntity});
}

final class AuthFailed extends AuthState {
  final String message;

  AuthFailed({required this.message});
}

final class AuthForgotSuccess extends AuthState {}

final class AuthLoggedIn extends AuthState {
  final String user;
  AuthLoggedIn({required this.user});
}
