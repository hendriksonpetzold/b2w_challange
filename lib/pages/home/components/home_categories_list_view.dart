import 'package:b2w_challange/pages/home/home_controller.dart';
import 'package:b2w_challange/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoriesListView extends GetView<HomeController> {
  const HomeCategoriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.greyish,
      )),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final list = controller.categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 140,
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Image(image: NetworkImage(list.urlImage)),
                  ),
                  Text(
                    list.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
