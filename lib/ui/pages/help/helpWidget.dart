import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HelpExpandable extends StatelessWidget {
  const HelpExpandable({
    Key? key,
    this.title = '',
    required this.body,
    required this.tapHeader,
    required this.controller,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Function tapHeader;
  final ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // controller: controller,
      child: ScrollOnExpand(
        child: Container(
          // height: 60,
          alignment: Alignment.center,

          child: ExpandablePanel(
            collapsed: SizedBox(),
            header: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  tapHeader();
                },
                child: Container(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // if (controller.expanded)
                        //   Container(
                        //     child: HeroIcon(
                        //       HeroIcons.chevronUp,
                        //       size: 18,
                        //     ),
                        //   ),
                        // if (!controller.expanded)
                        //   Container(
                        //     alignment: Alignment.center,
                        //     child: HeroIcon(
                        //       HeroIcons.chevronDown,
                        //       size: 18,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            expanded: body,
          ),
        ),
      ),
    );
  }
}
