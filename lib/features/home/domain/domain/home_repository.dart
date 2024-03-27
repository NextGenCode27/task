import 'package:fpdart/fpdart.dart';
import 'package:task/core/error/error.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, void>> homeLogOut();
}
