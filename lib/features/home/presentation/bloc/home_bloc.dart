import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/usecase/log_out_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LogOutUsecase _logOutUsecase;
  HomeBloc({
    required LogOutUsecase logOutUsecase,
  })  : _logOutUsecase = logOutUsecase,
        super(HomeInitial()) {
    on<HomeEvent>(_mapHomeEventToState);
    on<HomeLogOutEvent>(_mapHomeLogOutEventToState);
  }

  FutureOr<void> _mapHomeEventToState(
      HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
  }

  FutureOr<void> _mapHomeLogOutEventToState(
      HomeLogOutEvent event, Emitter<HomeState> emit) async {
    final res = await _logOutUsecase.call(NoParams());
    res.fold(
      (error) => emit(HomeFailed(error.message)),
      (user) => emit(HomeLogOut()),
    );
  }
}
