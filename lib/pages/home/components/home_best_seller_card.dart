import 'package:b2w_challange/style/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBestSellerCard extends StatelessWidget {
  final String image;
  const HomeBestSellerCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyish,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Image(image: NetworkImage(image)),
          ),
        ],
      ),
    );
  }
}
