class ProductInfoModel {
  final String id;
  final String name;
  final String description;
  final String photo;
  final String expirationDate;
  final List<String> categories;

  ProductInfoModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.expirationDate,
      required this.categories});
}
