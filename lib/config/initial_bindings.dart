import 'package:b2w_challange/repository/banner_repository.dart';
import 'package:b2w_challange/repository/category_repository.dart';
import 'package:b2w_challange/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(BannerRepository(dio: Get.find<Dio>()));
    Get.put(CategoryRepository(dio: Get.find<Dio>()));
    Get.put(ProductRepository(dio: Get.find<Dio>()));
  }
}
