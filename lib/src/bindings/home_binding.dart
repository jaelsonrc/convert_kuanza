import 'package:get/get.dart';
import 'package:mvc_kuanza/src/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
