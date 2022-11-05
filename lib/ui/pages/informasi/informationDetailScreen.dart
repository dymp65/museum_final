import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:museum/models/models.dart';

class InformationDetailScreen extends StatefulWidget {
  final InformationModel informasi;

  InformationDetailScreen({Key? key, required this.informasi})
      : super(key: key);

  @override
  State<InformationDetailScreen> createState() =>
      _InformationDetailScreenState();
}

class _InformationDetailScreenState extends State<InformationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6F8),
      body: _informationDetailBuilder(),
    );
  }

  Widget _informationDetailBuilder() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff232933),
            ),
          ),
          title: Text(
            widget.informasi.title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xff232933),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.informasi.thumbnail,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  bottom: -20,
                  child: _mainInformation(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(16),
              child: Text(
                widget.informasi.description ?? '',
              ),
            ),
          ]),
        )
      ],
    );
  }

  Widget _mainInformation() {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 8),
            color: Colors.black.withAlpha(20),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tahun Pembuatan'),
              const SizedBox(height: 8),
              Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          VerticalDivider(
            thickness: 2,
            width: 20,
            color: Colors.black,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Pencipta'),
              const SizedBox(height: 8),
              Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
