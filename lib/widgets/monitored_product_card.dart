import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/pages/add_product.dart';
import 'package:food_waste_2/pages/product_details.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:food_waste_2/widgets/monitored_product_details.dart';
import 'package:provider/provider.dart';

class MonitoredProductCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String propertyName;
  final String location;
  final String expirationDate;

  const MonitoredProductCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.propertyName,
    required this.location,
    required this.expirationDate,
  }) : super(key: key);

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
              builder: (context) => MonitoredProductDetails(
                key: const ValueKey<String>('AddProduct'),
                id: id,
                imageUrl: imageUrl,
                propertyName: propertyName,
                location: location,
                token: user.user.token,
                expirationDate: expirationDate,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text(
                    propertyName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                      child: () {
                        DateTime parseDate =
                            new DateFormat("yyyy-MM-dd").parse(expirationDate);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = DateFormat('MM/dd/yyyy');
                        var outputDate = outputFormat.format(inputDate);
                        return Text(
                          'Expires: $outputDate',
                          style: Theme.of(context).textTheme.bodyText2,
                        );
                      }(),
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
