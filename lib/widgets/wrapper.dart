import 'package:flutter/material.dart';
import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/pages/authenticate.dart';
import 'package:food_waste_2/pages/home.dart';
import 'package:food_waste_2/pages/sign_in.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    // return either the Home or Authenticate widget
    if (user.user.username == "") {
      return const Authenticate();
    } else {
      print(user.user.username);
      return const Home();
    }
  }
}