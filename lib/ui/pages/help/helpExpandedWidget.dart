import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    offset: const Offset(0, 2),
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
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  active == true
                      ? HeroIcon(
                          HeroIcons.chevronUp,
                          size: 24,
                          color: Colors.black,
                        )
                      : HeroIcon(
                          HeroIcons.chevronDown,
                          size: 24,
                          color: Colors.black,
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: active,
            child: widget.body,
          ),
        ],
      ),
    );
  }
}
