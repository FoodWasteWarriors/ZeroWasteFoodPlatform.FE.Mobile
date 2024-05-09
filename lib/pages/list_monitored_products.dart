import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/product_info.dart';
import 'package:food_waste_2/models/store_product.dart';
import 'package:food_waste_2/widgets/monitored_product_card.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:http/http.dart' as http;

class ListMonitoredProducts extends StatefulWidget {
  final List<ProductInfoModel> products;

  const ListMonitoredProducts({super.key, required this.products});

  @override
  State<ListMonitoredProducts> createState() => _ListMonitoredProductsState();
}

class _ListMonitoredProductsState extends State<ListMonitoredProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (var product in widget.products)
            MonitoredProductCard(
              id: product.id,
              imageUrl: product.photo,
              propertyName: product.name,
              location: product.categories.toString(),
              expirationDate: product.expirationDate,
            ),
        ].divide(const SizedBox(height: 12)),
      ),
    );
  }
}
