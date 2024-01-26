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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CommonText(
              text: "Splash Screen",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
