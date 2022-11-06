import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:museum/shareds/theme.dart';
import 'package:museum/shareds/value.dart';
import 'package:museum/ui/pages/welcomeScreen.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  const OnboardingWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0B0B23),
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  subTitle,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.7,
                      color: Color(0xff8B95A5),
                    ),
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
