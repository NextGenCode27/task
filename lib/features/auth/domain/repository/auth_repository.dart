import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/features/auth/domain/entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String username,
    required String email,
    required String phone,
    required String avatarUrl,
    required String password,
  });

  Future<Either<Failure, void>> forgot({required String email});

  Future<Either<Failure, String>> getCurrentUserData();
}
