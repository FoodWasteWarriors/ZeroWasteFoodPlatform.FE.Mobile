import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/product_info.dart';
import 'package:food_waste_2/pages/add_product.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:food_waste_2/services/product.dart';
import 'package:food_waste_2/widgets/recent_product_card.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../services/user_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:food_waste_2/widgets/search_bar.dart';
import 'package:http/http.dart' as http;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  bool canRequestFocus = true;
  String barcodeValue = "";

  // text controller
  final TextEditingController textController = TextEditingController();

  // focus node
  final FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: UserService.getUser(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final shopGetUserResponse = snapshot.data!;
        return GestureDetector(
          child: Scaffold(
            key: const Key('shopScaffold'),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await FlutterBarcodeScanner.scanBarcode(
                        '#FF0000', 'Cancel', true, ScanMode.BARCODE)
                    .then((value) => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProduct(
                                key: const ValueKey<String>('AddProduct'),
                                id: value,
                              ),
                            ),
                          )
                        });
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              elevation: 8,
              child: Icon(
                Icons.camera_alt,
                color: FlutterFlowTheme.of(context).info,
                size: 24,
              ),
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 6, 16, 6),
                            child: Container(
                              width: 53,
                              height: 53,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent1,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    'https://picsum.photos/seed/626/600',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Welcome, ${snapshot.data!.username}!',
                              style:
                                  FlutterFlowTheme.of(context).headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 16, 0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20,
                              buttonSize: 40,
                              icon: Icon(
                                Icons.notifications_none,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    StickyHeader(
                      overlapHeaders: false,
                      header: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).secondaryBackground,
                              FlutterFlowTheme.of(context).accent4
                            ],
                            stops: const [0, 1],
                            begin: const AlignmentDirectional(0, -1),
                            end: const AlignmentDirectional(0, 1),
                          ),
                        ),
                        child: StickySearchBar(
                          controller: textController,
                          focusNode: textFocusNode,
                          onChanged: (value) {
                            print("SearchBar onChanged: $value");
                          },
                          onFilterPressed: () {
                            print("Filter button pressed");
                          },
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                            child: Text(
                              'Top Beaches',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 4),
                            child: Container(
                              width: double.infinity,
                              height: 270,
                              decoration: const BoxDecoration(),
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const RecentProductCard(
                                      imageUrl:
                                          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2h8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60",
                                      beachName: "beachName",
                                      pricePerNight: "pricePerNight")
                                ].divide(const SizedBox(width: 16)),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 0, 12),
                                  child: Text(
                                    'Recent Properties',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 44),
                                  child: FutureBuilder(
                                    future: () async {
                                      final user = Provider.of<UserProvider>(context);
                                      // Simulate a network request
                                      try {
                                        final response = await http.get(
                                            Uri.parse(
                                                'http://10.0.2.2:5157/api/v1/MonitoredProduct?page=1&pageSize=10'),
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                              'Accept': '*/*',
                                              'Authorization':
                                                  'Bearer ${user.user.token}',
                                            });
                                        final body = jsonDecode(response.body) as Map<String, dynamic>;
                                        final data = body['data'] as List<dynamic>;
                                        print(data[0]['id']);
                                        print(data[0]['name']);
                                        print(data[0]['description']);
                                        print(data[0]['photo']);
                                        print(data[0]['expirationDate']);
                                        print(data[0]['categories']);

                                        List<ProductInfoModel> products = [];
                                        for (var i = 0; i < data.length; i++) {
                                          products.add(ProductInfoModel(
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
                                          return null;
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final shopGetProductsResponse =
                                          snapshot.data!;
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
                                              pricePerNight: product.expirationDate,
                                              location: product.categories.toString(),
                                            ),
                                        ].divide(const SizedBox(height: 12)),
                                      );
                                    },
                                  ),

                                  /* ListView(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      const ProductCard(
                                        id: '1',
                                        imageUrl:
                                            'https://images.unsplash.com/photo-1597475681177-809cfdc76cd2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2hob3VzZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60',
                                        propertyName: 'propertyName1',
                                        pricePerNight: 'pricePerNight',
                                        location: 'location',
                                      ),
                                      const ProductCard(
                                          id: '2',
                                          imageUrl:
                                              "https://images.unsplash.com/photo-1597475681177-809cfdc76cd2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2hob3VzZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60",
                                          propertyName: "propertyName",
                                          pricePerNight: "pricePerNight",
                                          location: "location"),
                                      const ProductCard(
                                          id: '3',
                                          imageUrl:
                                              "https://images.unsplash.com/photo-1597475681177-809cfdc76cd2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2hob3VzZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60",
                                          propertyName: "propertyName",
                                          pricePerNight: "pricePerNight",
                                          location: "location"),
                                    ].divide(const SizedBox(height: 12)),
                                  ), */
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
