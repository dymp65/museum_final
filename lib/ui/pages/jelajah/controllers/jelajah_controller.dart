import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';


class JelajahController extends GetxController {
  final mapController = MapController();

  final position = Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0)
      .obs;

  final networkInfo = NetworkInfo().obs;
  final connectionStatus = "".obs;

  final isLoading = true.obs;

  final mapHeading = 180.0.obs;

  @override
  void onInit() {
    getUserLocation();
    _setupStream();
    initNetworkInfo();
    getBluetoothPermission();
    super.onInit();
  }

  //get wifi name
  Future<void> initNetworkInfo() async {
    String? wifiName;

    try {
      if (await Permission.location.serviceStatus.isEnabled) {
        //location enabled
        var status = await Permission.location.status;
        if (status.isGranted) {
          //location granted
          if (!kIsWeb && Platform.isIOS) {
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await networkInfo.value.getWifiName();
            } else {
              wifiName = await networkInfo.value.getWifiName();
            }
          } else {
            wifiName = await networkInfo.value.getWifiName();
          }
        } else if (status.isDenied) {
          //location denied
          Map<Permission, PermissionStatus> status = await [
            Permission.location,
          ].request();
          log(status.toString());
        } else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
      } else {
        //location is disabled
        openAppSettings();
      }
    } on PlatformException catch (_) {
      wifiName = 'Failed to get Wifi Name';
    }

    connectionStatus.value = wifiName ?? "";
  }

  Future<void> getBluetoothPermission() async {
    print("hello");
    // try {
    // var bluetoothStatus = await Permission.bluetooth.request();
    // print(bluetoothStatus);
    //   if (bluetoothStatus.isGranted) {
    //     //location enabled
    //     var status = await Permission.bluetoothScan.status;
    //     if (status.isGranted) {
    //       //bluetooth scan granted
    //
    //     } else if (status.isDenied) {
    //       //location denied
    //       Map<Permission, PermissionStatus> status = await [
    //         Permission.bluetooth,
    //         Permission.bluetoothScan,
    //       ].request();
    //       log(status.toString());
    //       Get.snackbar(
    //         "",
    //         "",
    //         borderRadius: 0,
    //         duration: const Duration(seconds: 4),
    //         margin: const EdgeInsets.symmetric(horizontal: 0),
    //         backgroundColor: alertColor,
    //         icon: const Icon(
    //           Icons.close,
    //           color: Colors.white,
    //         ),
    //         titleText: Text(
    //           "Akses Bluetooth Gagal",
    //           style: whiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //         messageText: Text(
    //           'Kami memerlukan akses bluetooth anda',
    //           style: whiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //       );
    //       openAppSettings();
    //
    //     } else if (status.isPermanentlyDenied) {
    //       Get.snackbar(
    //         "",
    //         "",
    //         borderRadius: 0,
    //         duration: const Duration(seconds: 4),
    //         margin: const EdgeInsets.symmetric(horizontal: 0),
    //         backgroundColor: alertColor,
    //         icon: const Icon(
    //           Icons.close,
    //           color: Colors.white,
    //         ),
    //         titleText: Text(
    //           "Akses Bluetooth Gagal",
    //           style: whiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //         messageText: Text(
    //           'Agar bisa menggunakan aplikasi, harap berikan akses bluetooth ke kami',
    //           style: whiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //       );
    //
    //       openAppSettings();
    //     }
    //   } else if(bluetoothStatus.isDenied) {
    //     //bluetooth denied
    //     openAppSettings();
    //   }
    // else {
    // //bluetooth permanently denied
    // openAppSettings();
    // }
    // } on PlatformException catch (e) {
    //   log(e.toString());
    // }
    var status = await Permission.bluetooth.status;
    if (status.isDenied) {
      await [
            Permission.bluetooth,
            Permission.bluetoothScan,
          ].request();
    }

    if (await Permission.bluetooth.status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    late LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isLoading.value = false;

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            Get.back();
            Get.back();
            return true;
          },
          child: const AlertDialog(
            title: Text('GPS Anda Tidak Aktif'),
            content:
                Text('Silakan hidupkan GPS di perangkat anda terlebih dahulu'),
          ),
        ),
      );

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //stream GPS location
  _setupStream() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      ),
    ).listen((event) {
      position.value = event;
      // LatLng latlong = LatLng(event.latitude, event.longitude);
      // mapController.moveAndRotate(latlong, 20.7, 180);
      initNetworkInfo();
      if (kDebugMode) {
        print(event);
      }
    }).onError((e) {
      if (e is TimeoutException) {
        if (kDebugMode) {
          print('Stream timeout');
        }
      } else {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  //get the user location for the first time app opened
  Future<void> getUserLocation() async {
    position.value = await _determinePosition();

    if (position.value.isMocked) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            Get.back();
            Get.back();
            return true;
          },
          child: const AlertDialog(
            title: Text('Fake GPS terdeteksi'),
            content: Text('Matikan Fake GPS terlebih dahulu'),
          ),
        ),
      );
    } else {
      // LatLng latlong =
      //     LatLng(position.value.latitude, position.value.longitude);
      mapController.rotate(180);
    }
  }

  void moveAndRotatePosition(double zoom) {
    LatLng latlong = LatLng(position.value.latitude, position.value.longitude);
    mapController.moveAndRotate(latlong, zoom, 180);
  }

  void movePosition(LatLng latlong, double zoom) {
    mapController.move(latlong, zoom);
  }

  void startLoading() {
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }
}
