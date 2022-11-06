import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museum/ui/pages/ar/arScreen.dart';
import 'package:museum/ui/pages/help/helpCenterScreen.dart';
import 'package:museum/ui/pages/museum/floorScreen.dart';

class MuseumScreen extends StatefulWidget {
  MuseumScreen({Key? key}) : super(key: key);

  @override
  State<MuseumScreen> createState() => _MuseumScreenState();
}

class _MuseumScreenState extends State<MuseumScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: CurvedNavBar(
        actionButton: CurvedActionBar(
          onTab: (value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ArScreen()));
          },
          activeIcon: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color(0xff409BEF), shape: BoxShape.circle),
            child: SvgPicture.asset(
              'assets/icons/scan.svg',
              width: 32,
              height: 32,
            ),
          ),
          inActiveIcon: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xff409BEF),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/scan.svg',
              width: 32,
              height: 32,
            ),
          ),
          text: "Scan AR",
        ),
        activeColor: const Color(0xff409BEF),
        navBarBackgroundColor: Colors.white,
        inActiveColor: const Color(0xff8B95A5),
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: Image.asset('assets/icons/compass-active.png'),
              inActiveIcon: Image.asset('assets/icons/compass.png'),
              text: 'Jelajah'),
          FABBottomAppBarItem(
            activeIcon: Image.asset('assets/icons/contact-active.png'),
            inActiveIcon: Image.asset('assets/icons/contact.png'),
            text: 'Informasi',
          ),
        ],
        bodyItems: [
          FloorScreen(),
          HelpCenterScreen(),
        ],
        // actionBarView: ArScreen(),
      ),
    );
  }
}
