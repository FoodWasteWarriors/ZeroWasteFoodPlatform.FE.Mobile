import 'package:food_waste_2/models/user.dart';

class UserService {
  static Future<UserModel> getUser() async {
    await Future.delayed(const Duration(seconds: 1));

    UserModel user = UserModel(
      uid: '123',
      name: 'John',
      surname: 'Doe',
      username: 'johndoe',
      dateOfBirth: DateTime(1990, 1, 1),
      email: '',
    );

    return user;
  }
}
