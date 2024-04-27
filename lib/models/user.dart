class UserModel {
  final String username;
  final String email;
  final String phoneNumber;

  UserModel(
      {required this.username, required this.email, required this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "username": String username,
        "email": String email,
        "phoneNumber": String phoneNumber,
      } =>
        UserModel(
          username: username,
          email: email,
          phoneNumber: phoneNumber,
        ),
      _ => throw Exception('Failed to create user'),
    };
  }
}
