import 'package:b2w_challange/pages/home/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCarouselPromotions extends GetView<HomeController> {
  const HomeCarouselPromotions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: controller.banners.length,
        options: CarouselOptions(
          autoPlay: true,
          height: MediaQuery.of(context).size.height * .25,
          viewportFraction: 1,
        ),
        itemBuilder: (context, index, realIndex) {
          final list = controller.banners[index];
          return Image(
            image: NetworkImage(list.urlImage),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
