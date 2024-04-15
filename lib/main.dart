import 'package:flutter/material.dart';
import 'package:food_waste_2/pages/create_account.dart';
import 'package:food_waste_2/pages/home.dart';
import 'package:food_waste_2/pages/profile.dart';
import 'package:food_waste_2/pages/sign_in.dart';
import 'package:provider/provider.dart';
import "../providers/user_provider.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // user future provider to get the data from the api
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            "/": (context) => const Home(),
            "/profile": (context) => const Profile(),
            "/sign_in": (context) => const SignIn(),
            "/create_account": (context) => const CreateAccount(),
          },
        ));
  }
}
