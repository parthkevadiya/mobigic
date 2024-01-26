import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_interview/controllers/splash_controller.dart';
import 'package:mobigic_interview/view/components/common_text.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashCon = Get.put<SplashController>(SplashController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            CommonText(
              text: "Splash Screen",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
