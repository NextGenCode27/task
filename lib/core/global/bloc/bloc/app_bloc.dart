import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/entity/user_entity.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppEvent>(_mapAppEventToMap);
    on<AppLoggedInEvent>(_mapAppUserLoggedInEventToState);
  }

  FutureOr<void> _mapAppEventToMap(AppEvent event, Emitter<AppState> emit) {
    emit(AppLoading());
  }

  FutureOr<void> _mapAppUserLoggedInEventToState(
      AppLoggedInEvent event, Emitter<AppState> emit) {
    if (event.userEntity == null) {
      emit(AppInitial());
    } else {
      emit(AppSuccess(userEntity: event.userEntity!));
    }
  }
}
