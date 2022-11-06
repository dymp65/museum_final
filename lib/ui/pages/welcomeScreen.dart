import 'dart:async';

// import 'package:wifi_connector/wifi_connector.dart';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museum/blocs/blocs.dart';
import 'package:museum/shareds/value.dart';
import 'package:museum/ui/components/buttonComponent.dart';
import 'package:museum/ui/pages/mainScreen.dart';
import 'package:open_settings/open_settings.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _wifiActive = false;
  bool _bluetoothActive = false;
  var ssid = 'museum';
  var password = 'museum12345';
  bool _appLoading = false;

  @override
  void initState() {
    context.read<ConnectCubit>().fetchConnect();
    checkConnection();
    super.initState();
  }

  checkConnection() async {
    var connect = await ConnectivityWrapper.instance.isConnected;
    setState(() {
      _wifiActive = connect;
    });
  }

  Future<void> _onConnectPressed() async {
    OpenSettings.openWIFISetting();
    setState(() {
      _appLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _appLoading = false;
    });

    var connectCheck = await ConnectivityWrapper.instance.isConnected;
    setState(() => _wifiActive = connectCheck);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectCubit, ConnectState>(
      listener: (context, state) {
        if (state is ConnectResult) {
          _wifiActive = state.connect;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _welcomeBuilder(),
      ),
    );
  }

  Widget _welcomeBuilder() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              Values.welcomeText,
              style: GoogleFonts.plusJakartaSans(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0B0B23),
                ),
              ),
            ),
          ),
          const SizedBox(height: 46),
          StreamBuilder<BluetoothState>(
            stream: FlutterBluePlus.instance.state,
            initialData: BluetoothState.unknown,
            builder: (context, snapshot) {
              final state = snapshot.data;

              if (state == BluetoothState.off) {
                return _configBluetooth(
                  'assets/images/bluetooth_off.png',
                  'Aktifkan Bluetooth',
                  'Aktifkan Bluetooth untuk menggunakan Aplikasi ini',
                  false,
                );
              }
              return _configBluetooth(
                'assets/images/bluetooth.png',
                'Aktifkan Bluetooth',
                'Aktifkan Bluetooth untuk menggunakan Aplikasi ini',
                true,
              );
            },
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          const SizedBox(height: 10),
          _configWifi(
            _wifiActive
                ? 'assets/images/wifi_new.png'
                : 'assets/images/wifi_new_off.png',
            'Cek Koneksi Internet',
            'Silakan sambungkan dengan Wi-Fi  "museum" untuk koneksi yang lebih stabil',
            false,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          const SizedBox(height: 10),
          _configHeadset(
            'Gunakan Headset / Headphone',
            'Silakan menggunakan headset/ earphone untuk menikmati audio  yang jernih',
            'assets/images/headphone.png',
          ),
          const SizedBox(height: 68),
          StreamBuilder<BluetoothState>(
            stream: FlutterBluePlus.instance.state,
            initialData: BluetoothState.unknown,
            builder: (context, snapshot) {
              final state = snapshot.data;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    if (_wifiActive && state == BluetoothState.on) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MuseumScreen(),
                        ),
                      );
                    }
                  },
                  child: CircleButton(
                    color: _wifiActive && state == BluetoothState.on
                        ? Color(0xff409BEF)
                        : Color(0xffDADADA),
                    active: _wifiActive && state == BluetoothState.on
                        ? true
                        : false,
                  ),
                  // CustomButton(
                  //   padding: 16,
                  //   text: 'Mulai Jelajahi Museum',
                  //   color: _wifiActive && state == BluetoothState.on
                  //       ? Color(0xff409BEF)
                  //       : Color(0xffDADADA),
                  // ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 32,
          ),
        ],
      ),
    );
  }

  Widget _configBluetooth(
      String image, String title, String desc, bool config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xff409BEF).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                image,
                height: 34,
                width: 34,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff232933),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      desc,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff626B79),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _appLoading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator())
                      : config
                          ? Text(
                              'Akses berhasil!',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                      0xFF3FA796,
                                    ),
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                AppSettings.openBluetoothSettings();
                              },
                              child: Text(
                                'Buka pengaturan Bluetooth',
                                style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF409BEF),
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _configWifi(String image, String title, String desc, bool config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xff409BEF).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                image,
                height: 34,
                width: 34,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff232933),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      desc,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff626B79),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _appLoading
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator())
                      : _wifiActive
                          ? _textWifiConnect()
                          : _textWifiNotConnect(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _configHeadset(String title, String desc, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xff409BEF).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                height: 42,
                width: 42,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff232933),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      desc,
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff626B79),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _textWifiConnect() {
    return Text(
      'Akses berhasil!',
      style: GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
            fontSize: 14,
            color: Color(
              0xFF3FA796,
            ),
            decoration: TextDecoration.underline),
      ),
    );
  }

  _textWifiNotConnect() {
    return InkWell(
      onTap: () async {
        _onConnectPressed();
      },
      child: Text(
        'Connect dengan Wi-Fi Museum',
        style: GoogleFonts.plusJakartaSans(
          textStyle: const TextStyle(
            color: Color(0xFF409BEF),
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
