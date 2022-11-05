import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 27.0;

/// --------------
/// Constant Color
/// --------------
Color primaryColor = const Color(0xffE8630A);
Color alertColor = const Color(0xffD43620);
Color successColor = const Color(0xff4E944F);
Color priceColor = const Color(0xff2C96F1);
Color whiteColor = const Color(0xffffffff);
Color blackColor = const Color(0xff000000);
Color greyColor = const Color(0xff828282);
Color fillColor = const Color(0xffc4c4c4);

MaterialColor primaryCustomSwatch = MaterialColor(0xffFBBD1C, {
  50: primaryColor,
  100: primaryColor,
  200: primaryColor,
  300: primaryColor,
  400: primaryColor,
  500: primaryColor,
  600: primaryColor,
  700: primaryColor,
  800: primaryColor,
  900: primaryColor,
});

/// --------------
/// Asset Location
/// --------------
/// Example: ${iconAsset}/logo.svg
String iconAsset = "assets/icons";
String imageAsset = "assets/images";

/// ------------
/// Device Size
/// ------------
double get deviceWidth => ScreenUtil().screenWidth;

double get deviceHeight => ScreenUtil().screenHeight;

/// ----------------
/// Status Bar Color
/// ----------------
void setStatusBar(
    {Brightness brightness = Brightness.dark,
    Color color = Colors.transparent}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, statusBarIconBrightness: brightness));
}

/// -----------------------------------
/// Font and size scaling screen utils
/// -----------------------------------
/// Initialize screen util and set default size
/// by device size
void setupScreenUtil(BuildContext context) {
  double baseWidth = MediaQuery.of(context).size.width;
  double baseHeight = MediaQuery.of(context).size.height;
  double defaultScreenUtilWidth = 1080;
  double defaultScreenUtilHeight = 1920;
  double iPadPro12InchWidth = 2048;
  double iPadPro12InchHeight = 2732;
  double designWidth = 0;
  double designHeight = 0;

  /// ipad 11-inch width: 834, height: 1194
  /// ipad 9-inch width: 768, height: 1024
  if (baseWidth >= 768) {
    designWidth = iPadPro12InchWidth;
  } else {
    designWidth = defaultScreenUtilWidth;
  }

  if (baseHeight >= 1024) {
    designHeight = iPadPro12InchHeight;
  } else {
    designHeight = defaultScreenUtilHeight;
  }

  ScreenUtil.init(
    context,
    designSize: Size(designWidth, designHeight),
  );
  // ScreenUtil.init(context,
  //     deviceSize: Size(baseWidth, baseHeight),
  //     designSize: Size(designWidth, designHeight),
  //     orientation: Orientation.portrait);
  // ScreenUtil.init(BoxConstraints(maxWidth: baseWidth, maxHeight: baseHeight),
  //     context: context,
  //     designSize: Size(designWidth, designHeight),
  //     orientation: Orientation.portrait);
}

bool isLargePhone(BuildContext context) =>
    MediaQuery.of(context).size.width > 600 ? true : false;

bool isNormalPhone(BuildContext context) =>
    MediaQuery.of(context).size.width > 400 &&
            MediaQuery.of(context).size.width < 600
        ? true
        : false;

bool isSmallPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < 400 ? true : false;

/// Setting height and width
double setWidth(double width) => ScreenUtil().setWidth(width);

double setHeight(double height) => ScreenUtil().setHeight(height);

/// Setting fontsize
double setFontSize(double size) => ScreenUtil().setSp(size);

/// -----------------------------------
/// Constant Base Text Styling
/// -----------------------------------

TextStyle styleTitle = TextStyle(
    fontSize: setFontSize(36), color: blackColor, fontWeight: FontWeight.w700);

TextStyle styleSubtitle =
    TextStyle(fontSize: setFontSize(32), color: blackColor);

TextStyle primaryTextStyle = GoogleFonts.dmSans(
  color: primaryColor,
  fontSize: setFontSize(60),
);
TextStyle blackTextStyle = GoogleFonts.dmSans(
  color: blackColor,
  fontSize: setFontSize(60),
);

TextStyle alertTextStyle = GoogleFonts.dmSans(
  color: alertColor,
  fontSize: setFontSize(60),
);

TextStyle successTextStyle = GoogleFonts.dmSans(
  color: successColor,
  fontSize: setFontSize(60),
);

TextStyle whiteTextStyle = GoogleFonts.dmSans(
  color: whiteColor,
  fontSize: setFontSize(60),
);

TextStyle priceTextStyle = GoogleFonts.dmSans(
  color: priceColor,
  fontSize: setFontSize(60),
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
