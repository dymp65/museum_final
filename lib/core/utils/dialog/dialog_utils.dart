import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:museum/ui/widgets/dialogs/info_dialog.dart';
import 'package:museum/ui/widgets/dialogs/loading_dialog.dart';

class DialogShow {
  static var inputController = TextEditingController();

  static void showInfo(
    String message,
    String title,
    String buttonText, {
    Function? onClick,
    Widget? contentTextWidget,
    bool dismiss = false,
  }) {
    showModal(
      context: Get.context!,
      configuration: FadeScaleTransitionConfiguration(
        barrierDismissible: dismiss,
      ),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickOK: () => onClick != null ? onClick() : Get.back(),
          clickText: buttonText,
          title: title,
          contentTextWidget: contentTextWidget,
        );
      },
    );
  }

  static void showChoose(
    String message,
    String title,
    String buttonText, {
    Function? onClick,
    Widget? contentTextWidget,
    String? cancelText,
    Function? onClickCancel,
  }) {
    showModal(
      context: Get.context!,
      configuration: const FadeScaleTransitionConfiguration(
        barrierDismissible: false,
      ),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickOK: () => onClick != null ? onClick() : Get.back(),
          onClickCancel: () =>
              onClickCancel != null ? onClickCancel() : Get.back(),
          clickText: buttonText,
          contentTextWidget: contentTextWidget,
          title: title,
          cancelText: cancelText,
        );
      },
    );
  }

  static void showLoading(String message) {
    showModal(
      context: Get.context!,
      configuration: const FadeScaleTransitionConfiguration(
        barrierDismissible: false,
      ),
      builder: (context) {
        return LoadingDialog(
          text: message,
        );
      },
    );
  }
}
