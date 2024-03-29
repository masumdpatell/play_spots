import 'package:play_spots/Controllers/popular_spot_controller.dart';
import 'package:play_spots/Data/Repository/cart_repo.dart';
import 'package:play_spots/Data/Repository/popular_spot_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/recommended_spot_controller.dart';
import '../Controllers/cart_controller.dart';
import '../Data/API/api_client.dart';
import '../Controllers/recommended_spot_controller.dart';
import '../Data/Repository/recommended_spot_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
