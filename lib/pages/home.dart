import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:food_waste_2/pages/add_product.dart';
import 'package:food_waste_2/pages/create_account.dart';
import 'package:food_waste_2/pages/profile.dart';
import 'package:food_waste_2/pages/shop.dart';
import 'package:food_waste_2/pages/sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
          child: <Widget>[
            Container(
              key: const ValueKey<String>('Shop'),
              color: Colors.white,
              child: const Shop(),
            ),
            Container(
                key: const ValueKey<String>('Profile'),
                color: Colors.white,
                child: const Center(
                  child: Profile(),
                )),
          ][selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
