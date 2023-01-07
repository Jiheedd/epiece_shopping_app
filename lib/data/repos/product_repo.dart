import 'package:get/get.dart';
import 'package:epiece_shopping_app/data/api/api_client.dart';
import 'package:epiece_shopping_app/models/product.dart';
import 'package:epiece_shopping_app/uitls/app_constants.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
   // print("I am repo.................");
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}