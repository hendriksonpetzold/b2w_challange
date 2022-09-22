import 'package:b2w_challange/pages/home/home_controller.dart';
import 'package:b2w_challange/pages/home/home_page.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: '/',
      binding: BindingsBuilder.put(() => HomeController()),
      page: () => const HomePage(),
    )
  ];
}
