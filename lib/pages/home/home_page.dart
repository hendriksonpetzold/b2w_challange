import 'package:b2w_challange/style/app_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        child: Text(
          'dataawdwadwa',
          style: TextStyle(fontFamily: AppFonts.customFont),
        ),
      ),
    );
  }
}
