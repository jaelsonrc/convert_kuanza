import 'package:get/get.dart';
import 'package:mvc_kuanza/src/bindings/home_binding.dart';
import 'package:mvc_kuanza/src/pages/home_page.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
