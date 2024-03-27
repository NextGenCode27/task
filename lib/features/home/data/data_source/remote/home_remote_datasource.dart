import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/error/exception.dart';

abstract interface class HomeRemoteDatasource {
  Future<void> homeLogOut();
}

class HomeRemoteDatasourceImp implements HomeRemoteDatasource {
  final SupabaseClient supabaseClient;
  HomeRemoteDatasourceImp(this.supabaseClient);
  @override
  Future<void> homeLogOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
