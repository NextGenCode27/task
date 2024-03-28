part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

final class AppLoggedInEvent extends AppEvent {
  final UserEntity? userEntity;

  AppLoggedInEvent({required this.userEntity});
}
