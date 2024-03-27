part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  final int currentIndex;

  HomeInitial({required this.currentIndex});
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final int currentIndex;

  HomeSuccess({required this.currentIndex});
}

final class HomeLogOut extends HomeState {}

final class HomeFailed extends HomeState {
  final String message;
  HomeFailed(this.message);
}
