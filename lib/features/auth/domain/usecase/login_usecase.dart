import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/core/global/entity/user_entity.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase implements Usecase<UserEntity, LoginParams> {
  final AuthRepository authRepository;
  LoginUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
