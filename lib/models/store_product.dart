import 'package:food_waste_2/models/category.dart';

class StoreProductModel {
  final double originalPrice;
  final int percentDiscount;
  final Map<String, dynamic>? business;
  final String id;
  final String name;
  final String description;
  final String photo;
  final String expirationDate;
  final List<String> categories;

  StoreProductModel(
      {required this.originalPrice,
      required this.percentDiscount,
      required this.business,
      required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.expirationDate,
      required this.categories});
}
