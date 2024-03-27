import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/error/exception.dart';
import 'package:task/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentSession;
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String username,
    required String email,
    required String phone,
    required String avatarUrl,
    required String password,
  });

  Future<void> forgot({required String email});

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourceImpl(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentSession!.user.id);
        return UserModel.fromJson(userData.first);
      }
      return null;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response =
          await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', response.user!.id);
      if (response.user == null) {
        throw ServerException(message: 'User is null.');
      }
      return UserModel.fromJson(userData.first);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> register({
    required String username,
    required String email,
    required String phone,
    required String avatarUrl,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': username,
          'phone': phone,
          'avatar_url': avatarUrl,
        },
      );

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', response.user!.id);
      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return UserModel.fromJson(userData.first);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> forgot({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
