import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:museum/shareds/constant.dart';

import '../controllers/load_ruangan_controller.dart';

class PopUpInfoScan extends GetView<LoadRuanganController> {
  const PopUpInfoScan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.namaRuangan.value == "Lantai_1B"
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6,
              ),
              child: Row(
                children: [
                  controller.namaRuangan.value == "Lantai_2A"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            "$imageAsset/image_mars.png",
                            height: 60,
                            width: 60,
                          ),
                        )
                      : Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "$imageAsset/image_kh.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "$imageAsset/image_globe.jpeg",
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(width: 18.0),
                  const Expanded(
                    child: Text(
                      "Scan objek seperti disamping",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => controller.closePopUp(),
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
