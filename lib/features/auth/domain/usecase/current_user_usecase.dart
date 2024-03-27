import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class CurrentUserUsecase implements Usecase<String, NoParams> {
  final AuthRepository authRepository;
  CurrentUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getCurrentUserData();
  }
}
