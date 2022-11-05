import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:museum/shareds/theme.dart';
import 'package:museum/shareds/value.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? textcolor;
  final Widget? leading;
  final Widget? trailing;
  final double? padding;
  Function()? onAction;
  CustomButton(
      {Key? key,
      this.color,
      required this.text,
      this.textcolor,
      this.leading,
      this.trailing,
      this.onAction,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: padding ?? 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color ?? blue,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textcolor ?? white),
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
