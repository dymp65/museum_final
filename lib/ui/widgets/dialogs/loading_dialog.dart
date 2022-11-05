import 'package:flutter/material.dart';

import 'package:museum/shareds/constant.dart';

class LoadingDialog extends StatelessWidget {
  final String? text;

  const LoadingDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
      content: Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: setFontSize(40),
        ),
      ),
    );
  }
}
