import 'package:food_waste_2/models/user.dart';

class UserService {
  static Future<UserModel> getUser() async {
    await Future.delayed(const Duration(seconds: 1));

    UserModel user = UserModel(
        username: 'John Doe',
        email: 'john@gmail.com',
        phoneNumber: '1234567890');

    return user;
  }
}
