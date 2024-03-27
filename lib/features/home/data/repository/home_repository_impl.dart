import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/error/error.dart';
import 'package:task/core/error/exception.dart';
import 'package:task/features/home/data/data_source/remote/home_remote_datasource.dart';
import 'package:task/features/home/domain/domain/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  HomeRepositoryImpl(this.homeRemoteDatasource);
  @override
  Future<Either<Failure, void>> homeLogOut() async {
    try {
      final user = await homeRemoteDatasource.homeLogOut();
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(message: e.message));
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
