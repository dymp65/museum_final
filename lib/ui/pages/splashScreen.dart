import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:museum/ui/pages/onboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAll(OnboardingScreen());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: _splashBuilder(),
    );
  }

  Widget _splashBuilder() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/logo.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
