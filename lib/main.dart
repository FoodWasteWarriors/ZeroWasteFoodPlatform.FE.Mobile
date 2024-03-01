import 'package:flutter/material.dart';
import 'package:food_waste_2/pages/home.dart';
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
    return MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      ),
    ], child: const MaterialApp(home: Scaffold(
        body: Center(
          child: Home(),
        ),
      )
    ));
      
  }
}
