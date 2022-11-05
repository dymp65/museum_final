import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../models/audio_model.dart';
import '../services/audio_service.dart';
import 'load_ruangan_controller.dart';

class LoadBluetoothController extends GetxController {
  //load the ruangan controller to parse the geojson
  final ruanganC = Get.put(LoadRuanganController());

  final audioModel = AudioModel().obs;

  final player = AudioPlayer();

  final statusRuangan1A = false.obs;
  final statusRuangan1B = false.obs;
  final statusRuangan2A = false.obs;

  Timer? timer;

  @override
  void onInit() {
    _scanBluetooth();

    timer =
        Timer.periodic(const Duration(seconds: 10), (_) => _scanBluetooth());
    super.onInit();
  }

  @override
  void onClose() {
    player.release();
    timer!.cancel();
    super.onClose();
  }

  Future<void> _scanBluetooth() async {
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    // Start scanning
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (kDebugMode) {
          // print('${r.device.name} found! rssi: ${r.rssi}');
        }

        //if the BLE name is contains BLE1a,BLE1B, or BLE2A,
        // then play the corresponding audio and load the geojson per room
        if (r.device.name == "BLE-1A") {
          if (!statusRuangan1A.value) {
            // Future.delayed(const Duration(seconds: 2)).then(
            //   (value) => playAudio("BLE-1A"),
            // );
            playAudio("BLE-1A");
            statusRuangan1A.value = true;
            statusRuangan1B.value = false;
            statusRuangan2A.value = false;
            ruanganC.namaRuangan.value = "Lantai_1A";
            await ruanganC.parseAndDrawAssetsOnMap();
          }
        }

        if (r.device.name == "BLE-1B") {
          if (!statusRuangan1B.value) {
            playAudio("BLE-1B");
            statusRuangan1B.value = true;
            statusRuangan1A.value = false;
            statusRuangan2A.value = false;
            ruanganC.namaRuangan.value = "Lantai_1B";
            await ruanganC.parseAndDrawAssetsOnMap();
          }
        }
        if (r.device.name == "BLE-2A") {
          if (!statusRuangan2A.value) {
            playAudio("BLE-2A");
            statusRuangan2A.value = true;
            statusRuangan1A.value = false;
            statusRuangan1B.value = false;
            ruanganC.namaRuangan.value = "Lantai_2A";
            await ruanganC.parseAndDrawAssetsOnMap();
          }
        }

        //just example
        if (r.device.name == "My BLE Tester") {
          if (!statusRuangan1A.value) {
            playAudio("BLE-2A");
            statusRuangan1A.value = true;
            statusRuangan1B.value = false;
            statusRuangan2A.value = false;
            ruanganC.namaRuangan.value = "Lantai_1A";
            await ruanganC.parseAndDrawAssetsOnMap();
          }
        }
      }
    });

    // Stop scanning
    flutterBlue.stopScan();
  }

  Future<void> playAudio(String name) async {
    print("called");

    final data = await getAudioPerRuangan(name);
    if (kDebugMode) {
      print("ini data");
      print(data);
    }
    if (data != null) {
      AudioModel audio = data;
      await player.stop();

      await player.play(UrlSource(audio.media!));
    }
  }

  //get the audio endpoint
  Future<dynamic> getAudioPerRuangan(String name) async {
    final item = await AudioService().getAudioPerRuangan(name);
    if (kDebugMode) {
      print("ini item");
      print(item);
    }

    if (item != null) {
      audioModel.value = AudioModel.fromJson(item);
      return audioModel.value;
    }
    return null;
  }
}
