import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/auth/domain/entity/user_entity.dart';
import 'package:task/features/auth/domain/usecase/current_user_usecase.dart';
import 'package:task/features/auth/domain/usecase/forgot_usecase.dart';
import 'package:task/features/auth/domain/usecase/login_usecase.dart';
import 'package:task/features/auth/domain/usecase/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final ForgotUsecase _forgotUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  AuthBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required ForgotUsecase forgotUsecase,
    required CurrentUserUsecase currentUserUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _forgotUsecase = forgotUsecase,
        _currentUserUsecase = currentUserUsecase,
        super(AuthInitial()) {
    on<AuthEvent>(_mapAuthEventToState);
    on<AuthLoginEvent>(_mapAuthLoginEventToState);
    on<AuthRegisterEvent>(_mapAuthRegisterEventToState);
    on<AuthForgotEvent>(_mapAuthForgotEventToState);
    on<AuthGetCurrentUserDataEvent>(_mapAuthGetCurrentUserDataEvent);
  }

  FutureOr<void> _mapAuthEventToState(
      AuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
  }

  FutureOr<void> _mapAuthLoginEventToState(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    final res = await _loginUsecase.call(
      LoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (error) => emit(AuthFailed(message: error.message)),
      (user) => emit(AuthSuccess(userEntity: user)),
    );
  }

  FutureOr<void> _mapAuthRegisterEventToState(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    final res = await _registerUsecase.call(
      RegisterParams(
        username: event.username,
        email: event.email,
        phone: event.phone,
        avatarUrl: '',
        password: event.password,
      ),
    );
    res.fold(
      (error) => emit(AuthFailed(message: error.message)),
      (user) => emit(AuthSuccess(userEntity: user)),
    );
  }

  FutureOr<void> _mapAuthForgotEventToState(
      AuthForgotEvent event, Emitter<AuthState> emit) async {
    final res = await _forgotUsecase.call(ForgotParams(email: event.email));
    res.fold(
      (error) => emit(AuthFailed(message: error.message)),
      (email) => emit(AuthForgotSuccess()),
    );
  }

  FutureOr<void> _mapAuthGetCurrentUserDataEvent(
      AuthGetCurrentUserDataEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUserUsecase.call(NoParams());
    res.fold(
      (error) => emit(AuthFailed(message: error.message)),
      (user) => emit(AuthLoggedIn(user: user)),
    );
  }
}
