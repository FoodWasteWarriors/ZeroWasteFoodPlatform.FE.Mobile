import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/store.dart';
//import 'package:food_waste_2/models/product_info.dart';
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

class BusinessDetails extends StatelessWidget {
  final StoreModel store;

  BusinessDetails({required this.store});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(store.logo),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            buildDetailRow(Icons.store, 'Brand', store.name),
            buildDetailRow(Icons.email, 'E-mail', store.email),
            buildDetailRow(Icons.phone, 'Phone', store.phoneNumber),
            buildDetailRow(Icons.location_on, 'Address', store.address),
            buildDetailRow(Icons.web, 'Website', store.website),
            buildDetailRow(Icons.description, 'Summary', store.description),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  late Future<StoreModel> futureStore;
  List<StoreProductModel> storeProducts = [];
  bool showCard = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    futureStore = getStoreDetails(widget.name);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.minScrollExtent) {
        if (showCard) {
          setState(() {
            showCard = false;
          });
        }
      } else {
        if (!showCard) {
          setState(() {
            showCard = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final data = body["data"] as Map<String, dynamic>;
      var tempProducts = await getStoreProducts(data['id']);
      storeProducts = tempProducts;
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
      throw Exception('Failed to load store products');
    }
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            StoreModel store = snapshot.data!;
            return Column(
              children: <Widget>[
                Visibility(
                  visible: showCard,
                  child: BusinessDetails(store: store),
                ),
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      for (var product in storeProducts)
                        ProductCard(
                          id: product.id,
                          imageUrl: product.photo,
                          propertyName: product.name,
                          pricePerNight: product.originalPrice.toString(),
                          location: product.categories.join(', '),
                          percentDiscount: product.percentDiscount,
                          expirationDate: product.expirationDate,
                          categories: product.categories,
                          business: product.business,
                        ),
                    ].divide(const SizedBox(height: 12)),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
