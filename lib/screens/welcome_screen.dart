import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'dart:ui' as ui;
import 'cant_access_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 42, 66, 131),
            Color.fromARGB(255, 30, 47, 92)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 1100 &&
                    constraints.maxHeight > 400) {
                  return _buildWideWelcome(screenSize);
                } else if (constraints.maxWidth <= 1100 &&
                    constraints.maxHeight > 400) {
                  return _buildNormalWelcome(screenSize);
                } else {
                  return CantAccessScreen(
                    mode: true,
                  );
                }
              },
            ),
          )),
    );
  }

  // Mobile User
  Widget _buildNormalWelcome(Size screenSize) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              width: screenSize.width * 0.8,
              child: _buildCover(screenSize),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.5,
                    constraints: const BoxConstraints(
                        maxWidth: 600, maxHeight: 300, minHeight: 250),
                    child: _buildPopUpText()))
          ],
        ));
  }

  // Web User
  Widget _buildWideWelcome(Size screenSize) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 800),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            child: _buildCover(screenSize),
          )),
          Expanded(
              child: Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.4,
            constraints: const BoxConstraints(maxWidth: 100, minHeight: 250),
            child: _buildPopUpText(),
          )),
        ],
      ),
    );
  }

  // Cover Image
  Widget _buildCover(Size screenSize) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100, minHeight: 350),
      child: Image(
        image: const AssetImage("images/assets/background.png"),
        width: screenSize.width,
        height: screenSize.height * 0.6,
      ),
    );
  }

  // Pop Up Text
  Widget _buildPopUpText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.grey.shade200.withOpacity(0.1)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Scaffold +",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Mudahkan perhitungan statistika anda seperti Regresi Linear, Menghitung Luas, hingga Menghitung Volume menggunakan aplikasi Scaffold Plus",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    CustomButtonHome(
                      text: 'Hitung Sekarang!',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
