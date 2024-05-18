import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/category.dart';
import 'package:food_waste_2/pages/add_product.dart';
import 'package:food_waste_2/pages/business_details.dart';
import 'package:food_waste_2/pages/product_details.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String propertyName;
  final String pricePerNight;
  final String location;
  final double percentDiscount;
  final String expirationDate;
  final List<String> categories;
  final Map<String, dynamic>? business;

  const ProductCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.propertyName,
    required this.pricePerNight,
    required this.location,
    required this.percentDiscount,
    required this.expirationDate,
    required this.categories,
    required this.business,
  }) : super(key: key);

/*Future<StoreModel> getStoreDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:5157/api/v1/Business/$id'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return StoreModel.fromJson(jsonDecode(body["data"].toString()));
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to load store details');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                key: const ValueKey<String>('AddProduct'),
                id: id,
                imageUrl: imageUrl,
                propertyName: propertyName,
                pricePerNight: pricePerNight,
                location: location,
                percentDiscount: percentDiscount,
                token: user.user.token,
                expirationDate: expirationDate,
                business: business,
              ),
            ),
          );
        },
        child: Container(
          width: 220,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, -1),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 2,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 0),
                                      child: Text(
                                        '$percentDiscount% OFF',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        propertyName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: () {
                          if (categories.isNotEmpty) {
                            return Text(categories.join(', '),
                                style: Theme.of(context).textTheme.labelSmall);
                          }
                        }()),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$$pricePerNight',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' \$${(double.parse(pricePerNight) * (1 - percentDiscount.toDouble() / 100)).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                          child: () {
                            DateTime parseDate = new DateFormat("yyyy-MM-dd")
                                .parse(expirationDate);
                            var inputDate =
                                DateTime.parse(parseDate.toString());
                            var outputFormat = DateFormat('MM/dd/yyyy');
                            var outputDate = outputFormat.format(inputDate);
                            return Text(
                              'Expires: $outputDate',
                              style: Theme.of(context).textTheme.bodyText2,
                            );
                          }(),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (business != null &&
                                business!.containsKey('name')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BusinessDetailsPage(
                                    name: business!['name'],
                                    token: user.user.token,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Listed by: ${business != null && business!.containsKey('name') ? business!['name'] : 'Not available'}',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
