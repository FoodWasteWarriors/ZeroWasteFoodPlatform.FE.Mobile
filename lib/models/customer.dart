class CustomerModel {
  final String username;
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String avatar;
  final String password;

  CustomerModel(
      {required this.username,
      required this.email,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.password});
}
