import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String reportName;
  final String productName;
  final String manufacturer;
  final String location;
  final String startDate;
  final String endDate;
  final int suppliedAmount;
  final int soldAmount;
  final String content;

  const ReportCard({
    Key? key,
    required this.reportName,
    required this.productName,
    required this.manufacturer,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.suppliedAmount,
    required this.soldAmount,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Container(
        width: 220,
        // min content
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/seed/1/200',
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reportName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Product: $productName',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Manufacturer: $manufacturer',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Location: $location',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Start date: $startDate',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'End date: $endDate',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Supplied amount: $suppliedAmount',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Sold amount: $soldAmount',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Content: $content',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8B97A2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
