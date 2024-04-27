import 'package:food_waste_2/models/customer.dart';
import 'package:food_waste_2/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Auth {
  Future<UserModel?> createCustomer(CustomerModel customer) async {
    print(
        'Create account with email: ${customer.email} and password: ${customer.password}');

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
        return Future.value(UserModel.fromJson(jsonDecode(response.body)));
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmail(String email, String password) {
    print('Sign in with email: $email and password: $password');

    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
