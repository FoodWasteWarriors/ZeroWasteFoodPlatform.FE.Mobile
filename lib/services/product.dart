import 'package:food_waste_2/models/product_info.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<ProductInfoModel>?> getProducts(context) async {
    // Simulate a network request
    print(context);
    try {
      final response = await http.get(
          Uri.parse(
              'http://10.0.2.2:5157/api/v1/MonitoredProduct?page=1&pageSize=10'),
          headers: {
                        'Content-Type': 'application/json',
                        'Accept': '*/*',
                        'Authorization': 'Bearer ',
                      });

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return null;
      } else {
        print('Failed to get products');
      }
    } catch (e) {
      print(e);
    }
  }
}
