import 'package:get/get.dart';
import 'package:mobigic_interview/view/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () => Get.off(() => HomeScreen()));
  }
}
