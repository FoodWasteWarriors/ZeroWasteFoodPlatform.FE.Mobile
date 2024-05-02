import 'package:flutter/material.dart';
import 'package:food_waste_2/models/customer.dart';
import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:provider/provider.dart';

class Auth {
  Future<UserModel?> createCustomer(CustomerModel customer) async {
    print(
        'Create account with email: $customer and password: ${customer.password}');

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
          'username': customer.email,
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
        final user = new UserModel(
          id: jsonDecode(response.body)['id'],
          username: customer.username,
          email: customer.email,
          phoneNumber: customer.phoneNumber,
          token: jsonDecode(response.body)['token'],
        );

        return Future.value(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        print('Failed to create user');
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
          username: user['username'],
          email: user['email'],
          phoneNumber: user['phoneNumber'],
          token: token['accessToken'],
        );
        print(token);
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
