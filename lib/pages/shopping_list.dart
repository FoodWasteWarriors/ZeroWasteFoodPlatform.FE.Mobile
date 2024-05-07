import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/store_product.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:http/http.dart' as http;

class ShoppingList extends StatefulWidget {
  final String id;
  final String token;

  const ShoppingList({super.key, required this.id, required this.token});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<StoreProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: FutureBuilder(
        future: () async {
          try {
            final response = await http.get(
                Uri.parse(
                    'http://10.0.2.2:5157/api/v1/Customer/shopping-list/${widget.id}'),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                  'Authorization': 'Bearer ${widget.token}',
                });
            final body = jsonDecode(response.body) as Map<String, dynamic>;
            print(body);
            final data = body['data'] as List<dynamic>;
            print(data[0]['id']);
            print(data[0]['name']);
            print(data[0]['description']);
            print(data[0]['photo']);
            print(data[0]['expirationDate']);
            print(data[0]['categories']);

            for (var i = 0; i < data.length; i++) {
              products.add(StoreProductModel(
                  originalPrice: data[i]['originalPrice'],
                  percentDiscount: data[i]['percentDiscount'],
                  business: data[i]['business'],
                  id: data[i]['id'],
                  name: data[i]['name'],
                  description: data[i]['description'],
                  photo: data[i]['photo'],
                  expirationDate: data[i]['expirationDate'],
                  categories: data[i]['categories']));
            }
            print(response.statusCode);
            if (response.statusCode == 200) {
              print(data);
              return products;
            } else {
              print('Failed to get products');
              Navigator.pop(context);
              return null;
            }
          } catch (e) {
            print(e);
            Navigator.pop(context);
          }
        }(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final shopGetProductsResponse = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              for (var product in shopGetProductsResponse)
                ProductCard(
                  id: product.id,
                  imageUrl: product.photo,
                  propertyName: product.name,
                  pricePerNight: product.originalPrice.toString(),
                  location: product.categories.toString(),
                  percentDiscount: product.percentDiscount,
                  expirationDate: product.expirationDate,
                  categories: product.categories,
                ),
            ].divide(const SizedBox(height: 12)),
          );
        },
      ),
    );
  }
}
