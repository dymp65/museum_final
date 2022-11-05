import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../models/geojson_model.dart';
import '../models/marker_model.dart';
import '../services/marker_service.dart';
import '../views/detail_jelajah_view.dart';
import 'jelajah_controller.dart';

class LoadRuanganController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final jelajahC = Get.find<JelajahController>();

  final allPolygons = <Polygon>[].obs;
  final markers = <Marker>[].obs;
  final userMarkers = <Marker>[].obs;
  final _marker = MarkerModel().obs;

  final namaRuangan = "Lantai_1".obs;
  final isPopUpOpen = true.obs;

  @override
  void onInit() {
    parseAndDrawAssetsOnMap();

    super.onInit();
  }

  //load and parse the geojson, then show on the map
  Future<void> parseAndDrawAssetsOnMap() async {
    isPopUpOpen.value = true;
    final geo = GeoJson();

    //clear polygons value
    allPolygons.clear();

    //clear markers value
    markers.clear();

    // List colors = [
    //   const Color(0xffF9E5A7),
    //   const Color(0xffDADCE0),
    //   const Color(0xffF1F3F4)
    // ];
    // int index = math.Random().nextInt(3);
    GeoSerie? geoSerie;

    final dataLantai1A =
        await rootBundle.loadString('assets/geojson/Lantai_1A.geojson');
    final dataLantai1B =
        await rootBundle.loadString('assets/geojson/Lantai_1B.geojson');
    final dataLantai2A =
        await rootBundle.loadString('assets/geojson/Lantai_2A.geojson');
    String? usedData;
    GeojsonModel item = GeojsonModel();

    switch (namaRuangan.value) {
      case "Lantai_1":
        usedData = dataLantai1A;
        //call the endpoint to get the marker
        processMarkerData("1");
        item = GeojsonModel.fromJson(jsonDecode(dataLantai1A));
        //get the user position marker per room
        userPositionMarker(0);
        break;
      case "Lantai_1A":
        usedData = dataLantai1A;
        //call the endpoint to get the marker
        processMarkerData("1");
        item = GeojsonModel.fromJson(jsonDecode(dataLantai1A));
        //get the user position marker per room
        userPositionMarker(1);
        break;
      case "Lantai_1B":
        usedData = dataLantai1B;
        item = GeojsonModel.fromJson(jsonDecode(dataLantai1B));
        //get the user position marker per room

        userPositionMarker(2);

        break;
      case "Lantai_2A":
        usedData = dataLantai2A;
        //call the endpoint to get the marker
        processMarkerData("2");
        item = GeojsonModel.fromJson(jsonDecode(dataLantai2A));
        //get the user position marker per room

        userPositionMarker(3);

        break;
      default:
    }
    if (kDebugMode) {
      print("loading ${namaRuangan.value}");
      print("ini item");
      // print(item.features!.first.properties!.warna!);
    }
    List<Color> colorList = [];
    // for (var i in geo.features) {
    //   print(i.properties);
    //   String col = i.properties!["warna"].replaceAll('#', '0xff');
    //   // print(col);
    //   Color color = Color(int.parse(col));
    //   colorList.add(color);
    // }

    geo.processedPolygons.listen((GeoJsonPolygon poli) async {
      //to get the polygons geoserie value
      geoSerie = GeoSerie(
        type: GeoSerieType.polygon,
        name: poli.geoSeries[0].name,
        geoPoints: [],
      );
      for (final serie in poli.geoSeries) {
        geoSerie!.geoPoints.addAll(serie.geoPoints);
      }
      // index = math.Random().nextInt(5);
      allPolygons.add(
        Polygon(
          points: geoSerie!.toLatLng(ignoreErrors: true),
          color: Colors.white,
          borderStrokeWidth: 1.0,
          borderColor: Colors.grey,
          isFilled: true,
        ),
      );
    });

    geo.endSignal.listen((_) => geo.dispose());
    if (kDebugMode) {
      print(namaRuangan);
    }

    await geo.parse(usedData!, verbose: false);
    LatLng latlong = LatLng(0.0, 0.0);
    double zoom = 0.0;

    switch (namaRuangan.value) {
      case "Lantai_1":
        zoom = 20.7;
        latlong = LatLng(-7.834049, 110.383903);
        break;
      case "Lantai_1A":
        zoom = 20.7;
        latlong = LatLng(-7.834049, 110.383903);
        break;
      case "Lantai_1B":
        zoom = 20.8;
        latlong = LatLng(-7.834307, 110.383879);

        break;
      case "Lantai_2A":
        zoom = 21.1;
        latlong = LatLng(-7.834087, 110.383977);

        break;
      default:
    }
    jelajahC.movePosition(latlong, zoom);
  }

  //get the marker but not dynamic by floor number
  Future<void> processMarkerData(String id) async {
    //call the endpoint to get the marker
    final data = await getObjectPoint(id);
    final geojson = GeoJson();
    if (kDebugMode) {
      print("hhh");
    }

    geojson.processedPoints.listen((GeoJsonPoint points) {
      for (var i in _marker.value.features!) {
        if (i.geometry!.coordinates![0] == points.geoPoint.point.longitude &&
            i.geometry!.coordinates![1] == points.geoPoint.point.latitude) {
          markers.add(
            Marker(
              height: 22,
              width: 22,
              point: points.geoPoint.point,
              builder: (ctx) => InkWell(
                onTap: () async {
                  if (kDebugMode) {
                    print("pressed ${i.properties!.title!}");
                  }
                  Size size =
                      await _calculateImageDimension(i.properties!.image!);

                  print(size);
                  Get.bottomSheet(
                    SizedBox(
                      // height: size.height >= 300
                      //     ? Get.height * 0.89
                      //     : Get.height * 0.75,
                      height: size.width >= 600
                          ? Get.height * 0.63
                          : size.width <= 300
                              ? Get.height * 0.63
                              : Get.height * 0.89,
                      child: DetailJelajahView(
                        propertiesModel: i.properties!,
                        size: size,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xffFF6464),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.0),
                    child: Image.network(i.properties!.image!),
                  ),
                ),
              ),
            ),
          );
        }
      }
    });

    geojson.endSignal.listen((_) => geojson.dispose());
    unawaited(geojson.parse(data, verbose: true));
  }

  //get the user position
  Future<void> userPositionMarker(int id) async {
    userMarkers.clear();
    //call the endpoint to get the marker
    final dataPosisi1 =
        await rootBundle.loadString('assets/geojson/Posisi_User_1.geojson');
    final dataPosisi1A =
        await rootBundle.loadString('assets/geojson/Posisi_User_1A.geojson');
    final dataPosisi1B =
        await rootBundle.loadString('assets/geojson/Posisi_User_1B.geojson');
    final dataPosisi2A =
        await rootBundle.loadString('assets/geojson/Posisi_User_2A.geojson');
    String? usedData;

    switch (id) {
      case 0:
        usedData = dataPosisi1;

        break;
      case 1:
        usedData = dataPosisi1A;

        break;
      case 2:
        usedData = dataPosisi1B;

        break;
      case 3:
        usedData = dataPosisi2A;

        break;
      default:
    }
    final geojson = GeoJson();
    if (kDebugMode) {
      print("hhh");
    }

    geojson.processedPoints.listen(
      (GeoJsonPoint points) {
        userMarkers.add(
          Marker(
            height: 30,
            width: 30,
            point: points.geoPoint.point,
            // builder: (ctx) => CustomPaint(
            //   painter: CirclePainterLocation(
            //     _controller,
            //     color: const Color(0xff409BEF).withOpacity(0.1),
            //   ),
            //   child: Container(
            //     height: 80,
            //     width: 80,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: const Color(0xff409BEF).withOpacity(0.3),
            //     ),
            //   ),
            // ),
            builder: (ctx) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff409BEF),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: SpinKitPulse(
                    size: 39,
                    color: Color(0xff409BEF),
                    duration: Duration(milliseconds: 2500),
                    // controller: _controller,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    geojson.endSignal.listen((_) => geojson.dispose());
    unawaited(geojson.parse(usedData!, verbose: true));
  }

  Future<Size> _calculateImageDimension(String url) {
    Completer<Size> completer = Completer();
    Image image = Image.network(url);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  Future<dynamic> getObjectPoint(String id) async {
    final item = await MarkerService().getObjectPoint(id);

    if (item != null) {
      _marker.value = MarkerModel.fromJson(item);
    }
    return json.encode(item);
  }

  closePopUp() {
    isPopUpOpen.value = false;
  }
}
