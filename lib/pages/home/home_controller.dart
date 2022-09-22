import 'package:b2w_challange/models/banner_model.dart';
import 'package:b2w_challange/models/category_model.dart';
import 'package:b2w_challange/repository/banner_repository.dart';
import 'package:b2w_challange/repository/category_repository.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  BannerRepository bannerRepository = Get.find<BannerRepository>();
  CategoryRepository categoryRepository = Get.find<CategoryRepository>();
  List<BannerModel> banners = [];
  RxList<CategoryModel> categories = RxList([]);

  @override
  onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    banners = await bannerRepository.fetchBanners();
  }

  Future<void> fetchCategories() async {
    categories.value = await categoryRepository.fetchCategory();
  }
}
