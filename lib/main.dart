import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museum/blocs/blocs.dart';
import 'package:museum/ui/pages/splashScreen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectCubit()),
        BlocProvider(create: (context) => UnityCubit()),
        BlocProvider(create: (context) => InformationCubit()),
      ],
      child: GetMaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 600,
          minWidth: 420,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(420, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ],
          background: Container(
            color: Colors.white,
          ),
        ),
        title: 'Museum AR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          canvasColor: Colors.transparent,
        ),
        home: //
            SplashScreen(),
        // MuseumScreen(),
      ),
    );
  }
}
