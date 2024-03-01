class UserModel {
  final String uid;
  final String name;
  final String surname;
  final String username;
  final DateTime dateOfBirth;
  final String email;

  UserModel(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.username,
      required this.dateOfBirth,
      required this.email});
}
