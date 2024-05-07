class ReportModel {
  final String id;
  final String reportName;
  final String productName;
  final String manufacturer;
  final String location;
  final String startDate;
  final String endDate;
  final int suppliedAmount;
  final int soldAmount;
  final String content;

  ReportModel(
      {required this.id,
      required this.reportName,
      required this.productName,
      required this.manufacturer,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.suppliedAmount,
      required this.soldAmount,
      required this.content});
}
