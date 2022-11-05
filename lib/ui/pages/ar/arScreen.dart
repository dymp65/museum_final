import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';

import '../jelajah/controllers/load_ruangan_controller.dart';
import '../jelajah/views/pop_up_info_scan.dart';

class ArScreen extends StatefulWidget {
  ArScreen({Key? key}) : super(key: key);

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: const Text(
      //     'Scan AR',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   leading: InkWell(
      //     onTap: () => Navigator.of(context).pop(),
      //     child: const Text(
      //       'Tutup',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 14,
      //       ),
      //     ),
      //   ),
      // ),
      body: _arBuilder(),
    );
  }

  Widget _arBuilder() {
    final loadRuanganC = Get.put(LoadRuanganController());

    return Stack(
      fit: StackFit.expand,
      children: [
        UnityWidget(
          onUnityCreated: onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
          fullscreen: true,
        ),
        Obx(
          () => Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 55.0,
                  horizontal: 30.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Tutup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Text(
                          'Scan AR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    loadRuanganC.isPopUpOpen.value
                        ? const PopUpInfoScan()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo?.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo?.buildIndex}');
  }
}
