import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class ForgotUsecase implements Usecase<void, ForgotParams> {
  final AuthRepository authRepository;
  ForgotUsecase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(ForgotParams params) async {
    return await authRepository.forgot(email: params.email);
  }
}

class ForgotParams {
  final String email;

  ForgotParams({required this.email});
}
