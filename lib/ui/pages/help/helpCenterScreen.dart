import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:museum/ui/pages/help/helpExpandedWidget.dart';
import 'package:museum/ui/pages/help_center/controllers/help_center_controller.dart';

import '../help_center/models/help_center_model.dart';

class HelpCenterScreen extends StatefulWidget {
  HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final ExpandableController controller = ExpandableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpCenterController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Help Center',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 1.0,
      ),
      body: _screenBuilder(),
    );
  }

  Widget _screenBuilder() {
    final controller = Get.find<HelpCenterController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 20),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    HelpCenterModel item = controller.items[index];
                    return HelpExpandedWidget(
                      title: '${item.question}',
                      body: _contentBuilder("${item.answer}"),
                    );
                  },
                  childCount: controller.items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentBuilder(String description) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Wrap(
        children: [
          Text(description),
        ],
      ),
    );
  }
}
