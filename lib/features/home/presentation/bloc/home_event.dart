part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeCurrentIndexEvent extends HomeEvent {
  final int currentIndex;

  HomeCurrentIndexEvent({required this.currentIndex});
}

final class HomeLogOutEvent extends HomeEvent {}
