import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:museum/shareds/theme.dart';
import 'package:museum/shareds/value.dart';
import 'package:museum/ui/components/buttonComponent.dart';

import 'package:museum/ui/widgets/onboardingWidget.dart';
import 'package:museum/ui/pages/welcomeScreen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  List<Widget> onBoardingWidget = [
    const OnboardingWidget(
      title: 'Augmented Reality',
      subTitle:
          'Anda akan mendapatkan Fitur Augmented Reality (AR) untuk melihat AR yang ada di Gedung Museum Muhammadiyah',
      image: 'assets/images/onboarding-one.png',
    ),
    const OnboardingWidget(
      title: 'Maps',
      subTitle:
          'Anda akan mendapatkan Fitur Maps (Live Location) di Gedung Museum Muhammadiyah',
      image: 'assets/images/onboarding-two.png',
    ),
    const OnboardingWidget(
      title: 'Audio Experience',
      subTitle:
          'Anda juga mendapatkan Fitur Audio Experience jika anda menggunakan perangkat audio eksternal/earphone',
      image: 'assets/images/onboarding-three.png',
    ),
  ];

  _onChangeIndex(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F8),
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onChangeIndex,
            controller: pageController,
            itemCount: onBoardingWidget.length,
            itemBuilder: (context, int index) {
              return onBoardingWidget[index];
            },
          ),
          Positioned(
            top: 64,
            right: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              ),
              child: Text(
                'Lewati',
                style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                    color: Color(0xff409BEF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 48,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(onBoardingWidget.length,
                          (int index) {
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 5,
                            width: (index == currentPage) ? 30 : 12,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (index == currentPage)
                                    ? Color(0xff409BEF)
                                    : Color(0xffD8D8D8)));
                      }),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (context) => MainScreen()));
                    },
                    child: AnimatedContainer(
                      // padding: const EdgeInsets.symmetric(horizontal: 36),
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 100),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      // width: (currentPage == (onBoardingWidget.length - 1))
                      //     ? Get.width - 64
                      //     : 0,
                      child: InkWell(
                        onTap: () {
                          if (currentPage >= 2) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                            );
                          } else {
                            pageController.jumpToPage(currentPage + 1);
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xff409BEF,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              'Selanjutnya',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingProperties {
  String image;
  String title;
  String subTitle;

  OnBoardingProperties(
    this.image,
    this.title,
    this.subTitle,
  );
}
