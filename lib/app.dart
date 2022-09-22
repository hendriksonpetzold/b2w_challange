import 'package:b2w_challange/config/initial_bindings.dart';
import 'package:b2w_challange/config/routes.dart';
import 'package:b2w_challange/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'B2W challange',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBindings(),
      getPages: Routes.routes,
    );
  }
}
