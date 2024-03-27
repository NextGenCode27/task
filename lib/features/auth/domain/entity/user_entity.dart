abstract class UserEntity {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String avatarUrl;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.avatarUrl,
  });
}
