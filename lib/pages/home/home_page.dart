import 'package:b2w_challange/pages/home/components/home_carousel_promotions.dart';
import 'package:b2w_challange/pages/home/components/home_categories_list_view.dart';
import 'package:b2w_challange/pages/home/home_controller.dart';
import 'package:b2w_challange/style/app_colors.dart';
import 'package:b2w_challange/style/app_fonts.dart';
import 'package:b2w_challange/style/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: const Icon(Icons.menu),
        title: Row(
          children: [
            SizedBox(
              height: 40,
              width: 30,
              child: Image(
                image: AssetImage(
                  AppImages.logoNavigationBar,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'a Lodjinha',
              style: TextStyle(
                fontFamily: AppFonts.customFont,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: controller.fetchBanners(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const HomeCarouselPromotions();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'Categorias',
              style: TextStyle(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const HomeCategoriesListView(),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'Mais vendidos',
              style: TextStyle(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
