import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/error/exception.dart';
import 'package:task/features/auth/data/data_source/remote/auth_remote_datasource.dart';
import 'package:task/core/global/entity/user_entity.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl(this.authRemoteDatasource);
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.login(
        email: email,
        password: password,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(
        Failure(message: e.message),
      );
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String username,
    required String email,
    required String phone,
    required String avatarUrl,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.register(
        username: username,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
        password: password,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(
        Failure(message: e.message),
      );
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> forgot({required String email}) async {
    try {
      final userEmail = await authRemoteDatasource.forgot(email: email);
      return right(userEmail);
    } on AuthException catch (e) {
      return left(
        Failure(message: e.message),
      );
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final userData = await authRemoteDatasource.getCurrentUserData();
      if (userData == null) {
        return left(Failure(message: 'Please, login to continue.'));
      }
      return right(userData);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }
}
