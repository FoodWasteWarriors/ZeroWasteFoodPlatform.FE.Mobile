import 'package:flutter/material.dart';
import 'package:food_waste_2/models/customer.dart';
import 'package:food_waste_2/models/store.dart';
import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:provider/provider.dart';

class Auth {
  Future<bool?> createStore(StoreModel store) async {
    print(
        'Create account with email: ${store.email} and password: ${store.password}');

    print(Platform.isAndroid);

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5157/api/v1/Auth/register-business'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Accept': '*/*',
        },
        body: jsonEncode(<String, String>{
          'username': store.username,
          'email': store.email,
          'phoneNumber': store.phoneNumber,
          'password': store.password,
          'address': store.address,
          'name': store.name,
          'website': store.website,
          'description': store.description,
          'logo': store.logo,
          'coverPhoto': store.coverPhoto,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create user');
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> createCustomer(CustomerModel customer) async {
    print(
        'Create account with email: $customer and password: ${customer.password}');
    print(customer.phoneNumber);
    print(customer.username);

    print(Platform.isAndroid);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5157/api/v1/Auth/register-customer'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Accept': '*/*',
        },
        body: jsonEncode(<String, String>{
          'username': customer.username,
          'email': customer.email,
          'phoneNumber': customer.phoneNumber,
          'firstName': customer.firstName,
          'lastName': customer.lastName,
          'avatar': customer.avatar,
          'password': customer.password,
        }),
      );

      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create user');
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> signInWithEmail(String email, String password) async {
    print('Create account with email: $email and password: $password');

    print(Platform.isAndroid);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5157/api/v1/Auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Accept': '*/*',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        final token = data['token'] as Map<String, dynamic>;
        final newUser = new UserModel(
          id: user['id'],
          role: user['role'],
          username: user['username'],
          email: user['email'],
          phoneNumber: user['phoneNumber'],
          token: token['accessToken'],
        );
        print(user);
        return Future.value(newUser);
      } else {
        print('Failed to create user');
      }
    } catch (e) {
      print(e);
    }
  }

  void logout(context) async {
    final id = Provider.of<UserModel>(context, listen: false).id;

    try {
      final response = await http
          .post(Uri.parse('http://10.0.2.2:5157/api/v1/Auth/login/$id'));

      if (response.statusCode == 200) {
        print('Logged out');
        Provider.of<UserProvider>(context, listen: false)
            .changeUserData(UserModel(
          id: '',
          role: '',
          username: '',
          email: '',
          phoneNumber: '',
          token: '',
        ));
      } else {
        print('Failed to logout');
      }
    } catch (e) {
      print(e);
    }
  }
}
