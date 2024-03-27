import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/domain/home_repository.dart';

class LogOutUsecase implements Usecase<void, NoParams> {
  final HomeRepository homeRepository;
  LogOutUsecase(this.homeRepository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await homeRepository.homeLogOut();
  }
}
