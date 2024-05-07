import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/product_info.dart';
import 'package:food_waste_2/models/report.dart';
import 'package:food_waste_2/models/store_product.dart';
import 'package:food_waste_2/pages/add_product.dart';
import 'package:food_waste_2/pages/list_monitored_products.dart';
import 'package:food_waste_2/pages/list_products.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:food_waste_2/services/product.dart';
import 'package:food_waste_2/widgets/recent_product_card.dart';
import 'package:food_waste_2/widgets/report_card.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../services/user_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/widgets/product_card.dart';
import 'package:food_waste_2/widgets/search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  bool canRequestFocus = true;
  String barcodeValue = "";
  List<StoreProductModel> products = [];
  bool isMounted = false;
  List<ReportModel> reports = [];

  // text controller
  final TextEditingController textController = TextEditingController();

  // focus node
  final FocusNode textFocusNode = FocusNode();

  List<ProductInfoModel> notificationProducts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    () async {
      if (isMounted) return;
      isMounted = true;
      if (user.user.role == "Admin") {
        try {
          final response2 = await http.get(
              Uri.parse(
                  'http://10.0.2.2:5157/api/v1/Report?page=1&pageSize=10'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer ${user.user.token}',
              });
          final body2 = jsonDecode(response2.body) as Map<String, dynamic>;
          final data = body2['data'] as List<dynamic>;
          print(data);

          List<ReportModel> tempReports = [];

          for (var i = 0; i < data.length; i++) {
            tempReports.add(ReportModel(
                id: data[i]['id'],
                reportName: data[i]['reportName'],
                endDate: data[i]['endDate'],
                location: data[i]['location'],
                manufacturer: data[i]['manufacturer'],
                productName: data[i]['productName'],
                soldAmount: data[i]['soldAmount'],
                startDate: data[i]['startDate'],
                suppliedAmount: data[i]['suppliedAmount'],
                content: data[i]['content']));
          }

          setState(() {
            reports = tempReports.toList();
          });
        } catch (e) {
          print(e);
        }
      }
      if (user.user.role == "Customer") {
        try {
          final response = await http.get(
              Uri.parse(
                  'http://10.0.2.2:5157/api/v1/StoreProduct?page=1&pageSize=10'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer ${user.user.token}',
              });
          final body = jsonDecode(response.body) as Map<String, dynamic>;
          final data = body['data'] as List<dynamic>;
          print(data[0]['id']);
          print(data[0]['name']);
          print(data[0]['description']);
          print(data[0]['photo']);
          print(data[0]['expirationDate']);
          print(data[0]['categories']);

          List<StoreProductModel> tempProducts = [];

          for (var i = 0; i < data.length; i++) {
            tempProducts.add(StoreProductModel(
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

          setState(() {
            products = tempProducts.toList();
          });

          final response2 = await http.get(
              Uri.parse(
                  'http://10.0.2.2:5157/api/v1/MonitoredProduct?page=1&pageSize=10'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer ${user.user.token}',
              });
          final body2 = jsonDecode(response.body) as Map<String, dynamic>;
          final data2 = body['data'] as List<dynamic>;

          var leastExpirationDate = DateTime.now().add(const Duration(days: 3));

          for (var i = 0; i < data2.length; i++) {
            var expirationDate = DateTime.parse(data2[i]['expirationDate']);
            if (expirationDate.isBefore(leastExpirationDate)) {
              notificationProducts.add(ProductInfoModel(
                  id: data2[i]['id'],
                  name: data2[i]['name'],
                  description: data2[i]['description'],
                  photo: data2[i]['photo'],
                  expirationDate: data2[i]['expirationDate'],
                  categories: data2[i]['categories']));
            }
          }
        } catch (e) {
          print(e);
        }
      } else {
        try {
          final response = await http.get(
              Uri.parse(
                  'http://10.0.2.2:5157/api/v1/StoreProduct/user/${user.user.id}'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': '*/*',
                'Authorization': 'Bearer ${user.user.token}',
              });
          final body = jsonDecode(response.body) as Map<String, dynamic>;
          final data = body['data'] as List<dynamic>;
          print(data[0]['id']);
          print(data[0]['name']);
          print(data[0]['description']);
          print(data[0]['photo']);
          print(data[0]['expirationDate']);
          print(data[0]['categories']);

          print("categories: ${data[0]['categories']}");

          List<StoreProductModel> tempProducts = [];

          for (var i = 0; i < data.length; i++) {
            tempProducts.add(StoreProductModel(
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

          setState(() {
            products = tempProducts.toList();
          });
        } catch (e) {
          print(e);
        }
      }
    }();

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
        final user = Provider.of<UserProvider>(context);
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
                                token: user.user.token,
                                role: user.user.role,
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
                                    'https://images.unsplash.com/photo-1514924013411-cbf25faa35bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1380&q=80',
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
                              'Welcome, ${user.user.username}',
                              style:
                                  FlutterFlowTheme.of(context).headlineMedium,
                            ),
                          ),
                          badges.Badge(
                            position: badges.BadgePosition.bottomStart(
                                bottom: 0, start: 0),
                            badgeContent: () {
                              if (user.user.role == "Customer") {
                                return Text(
                                  '${notificationProducts.length}',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                );
                              }
                              ;
                            }(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 16, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 20,
                                buttonSize: 40,
                                icon: Icon(
                                  Icons.notifications_none,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed 1...');
                                  if (user.user.role == "Customer") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ListMonitoredProducts(
                                          key: const ValueKey<String>(
                                              'AddProduct'),
                                          products: notificationProducts,
                                        ),
                                      ),
                                    );
                                  }
                                  ;
                                },
                              ),
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
                          onChanged: (value) async {
                            // print notification products with iteration
                            for (var product in notificationProducts) {
                              print('Notification Product: ${product.name}');
                            }

                            if (user.user.role == "Admin") {
                              try {
                                final response2 = await http.get(
                                    Uri.parse(
                                        'http://10.0.2.2:5157/api/v1/Report?page=1&pageSize=10&ReportNameQuery=$value'),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Accept': '*/*',
                                      'Authorization':
                                          'Bearer ${user.user.token}',
                                    });
                                final body2 = jsonDecode(response2.body)
                                    as Map<String, dynamic>;
                                final data = body2['data'] as List<dynamic>;
                                print(data);

                                List<ReportModel> tempReports = [];

                                for (var i = 0; i < data.length; i++) {
                                  tempReports.add(ReportModel(
                                      id: data[i]['id'],
                                      reportName: data[i]['reportName'],
                                      endDate: data[i]['endDate'],
                                      location: data[i]['location'],
                                      manufacturer: data[i]['manufacturer'],
                                      productName: data[i]['productName'],
                                      soldAmount: data[i]['soldAmount'],
                                      startDate: data[i]['startDate'],
                                      suppliedAmount: data[i]['suppliedAmount'],
                                      content: data[i]['content']));
                                }

                                setState(() {
                                  reports = tempReports.toList();
                                });
                              } catch (e) {
                                print(e);
                              }
                            }

                            if (user.user.role == "Customer") {
                              try {
                                final response = await http.get(
                                    Uri.parse(
                                        'http://10.0.2.2:5157/api/v1/StoreProduct?page=1&pageSize=10&NameQuery=$value'),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Accept': '*/*',
                                      'Authorization':
                                          'Bearer ${user.user.token}',
                                    });
                                final body = jsonDecode(response.body)
                                    as Map<String, dynamic>;
                                final data = body['data'] as List<dynamic>;
                                print(data[0]['id']);
                                print(data[0]['name']);
                                print(data[0]['description']);
                                print(data[0]['photo']);
                                print(data[0]['expirationDate']);
                                print(data[0]['categories']);

                                List<StoreProductModel> tempProducts = [];

                                for (var i = 0; i < data.length; i++) {
                                  tempProducts.add(StoreProductModel(
                                      originalPrice: data[i]['originalPrice'],
                                      percentDiscount: data[i]
                                          ['percentDiscount'],
                                      business: data[i]['business'],
                                      id: data[i]['id'],
                                      name: data[i]['name'],
                                      description: data[i]['description'],
                                      photo: data[i]['photo'],
                                      expirationDate: data[i]['expirationDate'],
                                      categories: data[i]['categories']));
                                }

                                setState(() {
                                  products = tempProducts
                                      .where((element) => element.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              try {
                                final response = await http.get(
                                    Uri.parse(
                                        'http://10.0.2.2:5157/api/v1/StoreProduct/user/${user.user.id}'),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Accept': '*/*',
                                      'Authorization':
                                          'Bearer ${user.user.token}',
                                    });
                                final body = jsonDecode(response.body)
                                    as Map<String, dynamic>;
                                final data = body['data'] as List<dynamic>;
                                print(data[0]['id']);
                                print(data[0]['name']);
                                print(data[0]['description']);
                                print(data[0]['photo']);
                                print(data[0]['expirationDate']);
                                print(data[0]['categories']);

                                List<StoreProductModel> tempProducts = [];

                                for (var i = 0; i < data.length; i++) {
                                  tempProducts.add(StoreProductModel(
                                      originalPrice: data[i]['originalPrice'],
                                      percentDiscount: data[i]
                                          ['percentDiscount'],
                                      business: data[i]['business'],
                                      id: data[i]['id'],
                                      name: data[i]['name'],
                                      description: data[i]['description'],
                                      photo: data[i]['photo'],
                                      expirationDate: data[i]['expirationDate'],
                                      categories: data[i]['categories']));
                                }

                                setState(() {
                                  products = tempProducts
                                      .where((element) => element.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                              } catch (e) {
                                print(e);
                              }
                            }
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
                          /* Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 0),
                            child: () {
                              final user = Provider.of<UserProvider>(context);
                              if (user.user.role == "Customer") {
                                return Text(
                                  'Categories',
                                  style:
                                      FlutterFlowTheme.of(context).labelMedium,
                                );
                              } else {
                                return Text(
                                  'My Products',
                                  style:
                                      FlutterFlowTheme.of(context).labelMedium,
                                );
                              }
                            }(),
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
                          ), */
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 0, 12),
                                    child: () {
                                      final user =
                                          Provider.of<UserProvider>(context);
                                      if (user.user.role == "Customer") {
                                        return Text(
                                          'Recommended for you',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                        );
                                      } else if (user.user.role == "Business") {
                                        return Text(
                                          'My Products',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                        );
                                      } else {
                                        return Text(
                                          'Reports',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                        );
                                      }
                                    }()),
                                ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: () {
                                    if (user.user.role == "Customer") {
                                      return [
                                        for (var product in products)
                                          ProductCard(
                                            id: product.id,
                                            imageUrl: product.photo,
                                            propertyName: product.name,
                                            pricePerNight: product.originalPrice
                                                .toString(),
                                            location:
                                                product.categories.toString(),
                                            percentDiscount:
                                                product.percentDiscount,
                                            expirationDate:
                                                product.expirationDate,
                                            categories: product.categories,
                                          ),
                                      ].divide(const SizedBox(height: 12));
                                    } else if (user.user.role == "Business") {
                                      return [
                                        for (var product in products)
                                          ProductCard(
                                            id: product.id,
                                            imageUrl: product.photo,
                                            propertyName: product.name,
                                            pricePerNight: product.originalPrice
                                                .toString(),
                                            location:
                                                product.categories.toString(),
                                            percentDiscount:
                                                product.percentDiscount,
                                            expirationDate:
                                                product.expirationDate,
                                            categories: product.categories,
                                          ),
                                      ].divide(const SizedBox(height: 12));
                                    } else {
                                      return [
                                        for (var report in reports)
                                          ReportCard(
                                            reportName: report.reportName,
                                            endDate: report.endDate,
                                            location: report.location,
                                            manufacturer: report.manufacturer,
                                            productName: report.productName,
                                            soldAmount: report.soldAmount,
                                            startDate: report.startDate,
                                            suppliedAmount:
                                                report.suppliedAmount,
                                            content: report.content,
                                          )
                                      ].divide(const SizedBox(height: 12));
                                    }
                                  }(),
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
