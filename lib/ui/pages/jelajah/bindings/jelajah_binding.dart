import 'package:get/get.dart';

import '../controllers/jelajah_controller.dart';
import '../controllers/load_bluetooth_controller.dart';
import '../controllers/load_ruangan_controller.dart';

class JelajahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadBluetoothController>(
          () => LoadBluetoothController(),
    );
    Get.lazyPut<LoadRuanganController>(
          () => LoadRuanganController(),
    );
    Get.lazyPut<JelajahController>(
          () => JelajahController(),
    );
  }
}
