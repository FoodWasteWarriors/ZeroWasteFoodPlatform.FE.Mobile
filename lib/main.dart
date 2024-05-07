import 'package:flutter/material.dart';
import 'package:food_waste_2/pages/create_account.dart';
import 'package:food_waste_2/pages/home.dart';
import 'package:food_waste_2/pages/profile.dart';
import 'package:food_waste_2/pages/sign_in.dart';
import 'package:food_waste_2/widgets/wrapper.dart';
import 'package:provider/provider.dart';
import "../providers/user_provider.dart";
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
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
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
