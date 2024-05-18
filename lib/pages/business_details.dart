import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_waste_2/models/store.dart';
import 'package:food_waste_2/models/product_info.dart';
import 'package:food_waste_2/models/store_product.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessDetailsPage extends StatefulWidget {
  final String name;
  final String token;
  BusinessDetailsPage({required this.name, required this.token});

  @override
  _BusinessDetailsPageState createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  late Future<StoreModel> futureStore;
  List<StoreProductModel> storeProducts = [];
  Future<StoreModel> getStoreDetails(String name) async {
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:5157/api/v1/Business/username/${name.toLowerCase()}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body["data"] as Map<String, dynamic>;
      var tempProducts = await getStoreProducts(data['id']);
      print(tempProducts);
      storeProducts = tempProducts;
      // Create the StoreModel object directly.
      return StoreModel(
        username: data['username'] as String? ?? '',
        email: data['email'] as String? ?? '',
        phoneNumber: data['phoneNumber'] as String? ?? '',
        password: data['password'] as String? ?? '',
        address: data['address'] as String? ?? '',
        name: data['name'] as String? ?? '',
        website: data['website'] as String? ?? '',
        description: data['description'] as String? ?? '',
        logo: data['logo'] as String? ?? '',
        coverPhoto: data['coverPhoto'] as String? ?? '',
      );
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load store details');
    }
  }

  Future<List<StoreProductModel>> getStoreProducts(String id) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5157/api/v1/StoreProduct/user/${id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final products = body["data"] as List<dynamic>;

      List<StoreProductModel> storeProducts = [];

      for (var i = 0; i < products.length; i++) {
        var product = products[i];
        var categoriesData = product['categories'] as List<dynamic>;
        List<String> categoriesList = [];
        for (var j = 0; j < categoriesData.length; j++) {
          categoriesList.add(categoriesData[j]['name']);
        }

        storeProducts.add(
          StoreProductModel(
            originalPrice: product['originalPrice'] as double? ?? 0.0,
            percentDiscount: product['percentDiscount'] as double? ?? 0.0,
            business: product['business'] as Map<String, dynamic>?,
            id: product['id'] as String? ?? '',
            name: product['name'] as String? ?? '',
            description: product['description'] as String? ?? '',
            photo: product['photo'] as String? ?? '',
            expirationDate: product['expirationDate'] as String? ?? '',
            categories: categoriesList,
          ),
        );
      }

      return storeProducts;
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load store products');
    }
  }

  @override
  void initState() {
    super.initState();
    futureStore = getStoreDetails(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder<StoreModel>(
        future: futureStore,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            StoreModel store = snapshot.data!;

            return Column(
              children: <Widget>[
                ListTile(
                  title: Text('Store Name'),
                  subtitle: Text(store.username ?? 'Not available'),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(store.email ?? 'Not available'),
                ),
                ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(store.phoneNumber ?? 'Not available'),
                ),
                ListTile(
                  title: Text('Website'),
                  subtitle: Text(store.website ?? 'Not available'),
                ),
                ListTile(
                  title: Text('Description'),
                  subtitle: Text(store.description ?? 'Not available'),
                ),
                Divider(),
                Text(
                  'Products',
                  style: Theme.of(context).textTheme.headline6,
                ),
                // Add your code to display products here
              ],
            );
          }
        },
      ),
    );
  }
}
