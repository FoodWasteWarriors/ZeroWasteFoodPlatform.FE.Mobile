import 'package:food_waste_2/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  UserProvider();

  void changeUserData(UserModel? user) async {
    this.user = user;
    notifyListeners();
  }
}
