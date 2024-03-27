import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/core/global/entity/user_entity.dart';
import 'package:task/features/auth/domain/repository/auth_repository.dart';

class CurrentUserUsecase implements Usecase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  CurrentUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.getCurrentUserData();
  }
}
