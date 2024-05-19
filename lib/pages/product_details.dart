import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String propertyName;
  final String pricePerNight;
  final String location;
  final double percentDiscount;
  final String token;
  final String expirationDate;
  final Map<String, dynamic>? business;
  final List<String> categories;

  const ProductDetails({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.propertyName,
    required this.pricePerNight,
    required this.location,
    required this.percentDiscount,
    required this.token,
    required this.expirationDate,
    required this.business,
    required this.categories,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int countControllerValue = 1;
  String? dropDownValue1 = 'Option 1';
  String? dropDownValue2 = 'Option 1';
  FormFieldController<String> dropDownValueController1 =
      FormFieldController<String>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 500,
                    child: Stack(
                      alignment: const AlignmentDirectional(0, 0),
                      children: [
                        Image.network(
                          widget.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.85, -0.4),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 50, 0, 0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        borderWidth: 1,
                                        buttonSize: 40,
                                        fillColor: const Color(0x7F0F1113),
                                        icon: const Icon(
                                          Icons.chevron_left_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 7,
                                  sigmaY: 6,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 110,
                                  decoration: const BoxDecoration(
                                    color: Color(0x31000000),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24, 20, 0, 0),
                                          child: Text(
                                            widget.propertyName,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        /* Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24, 8, 24, 0),
                                          child: Text(
                                            'Effortlessly flow from one space to the next in this sleeveless take on the classic trench coat. ',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ), */
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${widget.pricePerNight}',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF0F1113),
                                    fontSize: 32,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '\$${(double.parse(widget.pricePerNight) * (1 - widget.percentDiscount / 100)).toStringAsFixed(2)}',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF0F1113),
                                    fontSize: 32,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        /* Container(
                          width: 156,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xFFE0E3E7),
                              width: 2,
                            ),
                          ),
                          child: FlutterFlowCountController(
                            decrementIconBuilder: (enabled) => FaIcon(
                              FontAwesomeIcons.minus,
                              color: enabled
                                  ? const Color(0xFF57636C)
                                  : const Color(0xFFE0E3E7),
                              size: 20,
                            ),
                            incrementIconBuilder: (enabled) => FaIcon(
                              FontAwesomeIcons.plus,
                              color: enabled
                                  ? const Color(0xFF0F1113)
                                  : const Color(0xFFE0E3E7),
                              size: 20,
                            ),
                            countBuilder: (count) => Text(
                              count.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF0F1113),
                                    fontSize: 24,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            count: countControllerValue ??= 1,
                            updateCount: (count) =>
                                setState(() => countControllerValue = count),
                            stepSize: 1,
                          ),
                        ), */
                      ],
                    ),
                  ),

                  // expiring date
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                    child: () {
                      DateTime parseDate = new DateFormat("yyyy-MM-dd")
                          .parse(widget.expirationDate);
                      var inputDate = DateTime.parse(parseDate.toString());
                      var outputFormat = DateFormat('MM/dd/yyyy');
                      var outputDate = outputFormat.format(inputDate);
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Expires on: ${outputDate}',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF0F1113),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      );
                    }(),
                  ),
                  /* Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 0, 0),
                    child: Text(
                      'Options',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: const Color(0xFF0F1113),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ), */
                  /* Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 5, 0, 0),
                    child: Text(
                      'Please make a selection from the options below.',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: const Color(0xFF57636C),
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ), */
                  /* Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 6, 0),
                            child: FlutterFlowDropDown(
                              options: const ['Option 1'],
                              onChanged: (val) => {
                                setState(
                                  () => dropDownValue1 = val,
                                ),
                              },
                              width: 150,
                              height: 50,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: const Color(0xFF0F1113),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              hintText: 'Select a Color',
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF57636C),
                                size: 15,
                              ),
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 2,
                              borderRadius: 50,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  24, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                6, 12, 0, 0),
                            child: FlutterFlowDropDown(
                              options: const ['Option 1'],
                              onChanged: (val) => {
                                setState(
                                  () => dropDownValue2 = val,
                                ),
                              },
                              width: 150,
                              height: 50,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: const Color(0xFF0F1113),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              hintText: 'Select a Size',
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF57636C),
                                size: 15,
                              ),
                              fillColor: Colors.white,
                              elevation: 2,
                              borderColor: const Color(0xFFE0E3E7),
                              borderWidth: 2,
                              borderRadius: 50,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  24, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), */
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF827AE1),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x411D2429),
                  offset: Offset(
                    0.0,
                    2,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: GestureDetector(
                onTap: () async {
                  try {
                    final response = await http.post(
                        Uri.parse(
                            'http://10.0.2.2:5157/api/v1/StoreProduct/add-to-shopping-list'),
                        headers: {
                          'Content-Type': 'application/json',
                          'Accept': '*/*',
                          'Authorization': 'Bearer ${widget.token}',
                        },
                        body: jsonEncode({
                          'productId': widget.id,
                        }));
                    final body =
                        jsonDecode(response.body) as Map<String, dynamic>;
                    print(body);
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      print('Success');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Product added to shopping list!',
                          ),
                        ),
                      );
                    } else {
                      print('Failed');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Text(
                        'Add To Shopping List',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
