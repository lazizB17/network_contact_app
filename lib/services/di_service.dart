import 'package:get/get.dart';
import '../pages/detail/detail_controller.dart';
import '../pages/home/home_controller.dart';

class DIService {
  // Dependency Injection
  static Future<void> init() async {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
  }
}
