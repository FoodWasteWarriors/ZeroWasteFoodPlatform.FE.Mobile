import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class RecentProductCard extends StatelessWidget {
  final String imageUrl;
  final String beachName;
  final double pricePerNight;
  final double percentDiscount;

  const RecentProductCard({
    Key? key,
    required this.imageUrl,
    required this.beachName,
    required this.pricePerNight,
    required this.percentDiscount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
      child: Container(
        width: 220,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          print("IconButton pressed");
                                        },
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      )),
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  beachName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                child: Row(
                  children: [
                    Text(
                      '\ ${pricePerNight}TL',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Outfit',
                            color: const Color(0xFF0F1113),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '\ ${(pricePerNight * (1 - percentDiscount / 100)).toStringAsFixed(2)}TL',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Outfit',
                            color: const Color(0xFF0F1113),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
