import 'package:b2w_challange/style/app_colors.dart';
import 'package:b2w_challange/style/app_fonts.dart';
import 'package:b2w_challange/style/app_images.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
      body: Container(),
    );
  }
}
