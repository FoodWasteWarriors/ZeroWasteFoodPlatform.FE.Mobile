class ProductInfoModel {
  final String id;
  final String name;
  final String description;
  final String photo;
  final String expirationDate;
  final List<dynamic> categories;

  ProductInfoModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.expirationDate,
      required this.categories});

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": String id,
        "name": String name,
        "description": String description,
        "photo": String photo,
        "expirationDate": String expirationDate,
        "categoriesId": List<String> categories
      } =>
        ProductInfoModel(
            id: id,
            name: name,
            description: description,
            photo: photo,
            expirationDate: expirationDate,
            categories: categories),
      _ => throw Exception('Failed to create product info'),
    };
  }
}
