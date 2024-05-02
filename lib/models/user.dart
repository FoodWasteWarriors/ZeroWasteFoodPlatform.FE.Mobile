class UserModel {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String token;

  UserModel(
      {required this.username, required this.email, required this.phoneNumber, required this.token, required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": String id,
        "username": String username,
        "email": String email,
        "phoneNumber": String phoneNumber,
        "token": String token
      } =>
        UserModel(
          id: id,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          token: token
        ),
      _ => throw Exception('Failed to create user'),
    };
  }
}
