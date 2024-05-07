import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/store_product.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:http/http.dart' as http;

class ListProducts extends StatefulWidget {
  final List<StoreProductModel> products;

  const ListProducts({super.key, required this.products});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications (about to expire)'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (var product in widget.products)
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
      ),
    );
  }
}
