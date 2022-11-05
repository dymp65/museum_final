import 'package:flutter/material.dart';

import '../jelajah/views/load_ruangan_view.dart';

// import 'package:museum/ui/widgets/mapWidget.dart';

class FloorScreen extends StatefulWidget {
  FloorScreen({Key? key}) : super(key: key);

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.1),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(top: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                color: Colors.black.withAlpha(20),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Jelajah Museum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _floorBuilder(),
      ),
    );
  }

  Widget _floorBuilder() {
    return const LoadRuanganView();
  }
}
