import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/auth/domain/entity/user_entity.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase implements Usecase<UserEntity, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await authRepository.register(
      username: params.username,
      email: params.email,
      phone: params.phone,
      avatarUrl: params.avatarUrl,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String avatarUrl;

  RegisterParams({
    required this.username,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.password,
  });
}
