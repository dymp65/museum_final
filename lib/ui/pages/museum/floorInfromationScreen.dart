import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:museum/models/models.dart';

class FloorInformationScreen extends StatefulWidget {
  final PropertiesModel propertiesModel;
  FloorInformationScreen({
    Key? key,
    required this.propertiesModel,
  }) : super(key: key);

  @override
  State<FloorInformationScreen> createState() => _FloorInformationScreenState();
}

class _FloorInformationScreenState extends State<FloorInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.network(widget.propertiesModel.image!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.propertiesModel.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.propertiesModel.article ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
          SizedBox(
            height: 52,
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'AR Available',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/icons/icon_scan.png",
                    height: 22,
                    width: 22,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
