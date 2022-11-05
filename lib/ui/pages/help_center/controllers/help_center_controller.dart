import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:museum/ui/pages/help_center/models/help_center_model.dart';

import '../services/help_center_servie.dart';

class HelpCenterController extends GetxController {
  final _items = <HelpCenterModel>[].obs;

  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = false.obs;

  List<HelpCenterModel> get items => _items;

  bool get isEmpty => _isEmpty.value;

  bool get isFailed => _isFailed.value;

  bool get isLoading => _isLoading.value;

  void startLoading() {
    _isLoading.value = true;
  }

  void stopLoading() {
    _isLoading.value = false;
  }

  @override
  void onInit() {
    getFaq();
    super.onInit();
  }

  @override
  void onClose() {
    _items.clear();
    _isEmpty.value = false;
    _isFailed.value = false;
    _isLoading.value = false;
    super.onClose();
  }

  Future<void> getFaq() async {
    if (!_isLoading.value) {
      startLoading();
      final items = await HelpCenterService().getFaq();
      if (kDebugMode) {
        print(items);
      }
      if (items == null) {
        _isFailed.value = true;
        _isEmpty.value = true;
      } else {
        _items.addAll(items);
        _isFailed.value = false;
      }
      if (kDebugMode) {
        print(items!.first.question!);
      }
      stopLoading();
    }
  }
}
