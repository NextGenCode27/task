part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

final class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String phone;
  final String password;

  AuthRegisterEvent({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });
}

final class AuthForgotEvent extends AuthEvent {
  final String email;

  AuthForgotEvent({required this.email});
}

final class AuthGetCurrentUserDataEvent extends AuthEvent {}
