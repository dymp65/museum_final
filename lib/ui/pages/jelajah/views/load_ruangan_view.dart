import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/jelajah_controller.dart';
import '../controllers/load_bluetooth_controller.dart';
import '../controllers/load_ruangan_controller.dart';

class LoadRuanganView extends GetView<LoadRuanganController> {
  const LoadRuanganView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapC = Get.put(JelajahController());
    Get.put(LoadBluetoothController());
    controller.parseAndDrawAssetsOnMap();
    return StreamBuilder<BluetoothState>(
      stream: FlutterBluePlus.instance.state,
      initialData: BluetoothState.unknown,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothState.off) {
          return const Center(
            child: Text("Hidupkan bluetooth anda"),
          );
        }
        return Stack(
          children: [
            FlutterMap(
              mapController: mapC.mapController,
              options: MapOptions(
                center: LatLng(-8.13354, 115.07207),
                zoom: 22,
                // maxZoom: 22,
                interactiveFlags: InteractiveFlag.none,
              ),
              nonRotatedChildren: const [],
              children: [
                TileLayer(
                  // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYXJpYWRueWFuYSIsImEiOiJjbDlhM24xZmkwbTkwM3dwOHJjdGs2aHV4In0.zHvX99xp70HuOMlWgwanbQ',
                  userAgentPackageName: 'com.example.app',
                  maxZoom: 18.5,
                ),
                PolygonLayer(polygons: controller.allPolygons),
                MarkerLayer(
                  markers: controller.markers,
                ),
                MarkerLayer(
                  markers: controller.userMarkers,
                )
              ],
            ),
            Obx(
              () => Positioned(
                right: 30,
                top: 30,
                child: Transform.rotate(
                  angle: ((mapC.mapHeading.value) * (pi / 180) * -1),
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/image_compass.png',
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
