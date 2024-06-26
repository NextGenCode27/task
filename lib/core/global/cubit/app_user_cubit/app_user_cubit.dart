import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/global/entity/user_entity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserEntity? userEntity) {
    if (userEntity == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(userEntity: userEntity));
    }
  }
}
