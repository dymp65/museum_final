import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class HelpExpandedWidget extends StatefulWidget {
  final bool? active;
  final String title;

  final Widget body;

  HelpExpandedWidget({
    Key? key,
    this.active = false,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  State<HelpExpandedWidget> createState() => _HelpExpandedWidgetState();
}

class _HelpExpandedWidgetState extends State<HelpExpandedWidget> {
  // final ExpandableController controller = ExpandableController();
  bool active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  active == true
                      ? HeroIcon(
                          HeroIcons.chevronUp,
                          size: 18,
                          color: Colors.black,
                        )
                      : HeroIcon(
                          HeroIcons.chevronDown,
                          size: 18,
                          color: Colors.black,
                        ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Visibility(
            visible: active,
            child: widget.body,
          ),
        ],
      ),
    );
  }
}
