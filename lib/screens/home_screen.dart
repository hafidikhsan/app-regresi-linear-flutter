import 'package:flutter/material.dart';
import 'cant_access_screen.dart';
import '../widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  // List of Map Menu
  List<Map> Features = [
    {
      "title": "Regresi Linear",
      "key": "regresilinear",
      "image": "images/assets/regresilinear.jpg",
      "detail":
          "Regresi Linear adalah suatu pendekatan untuk memantapkan hubungan antara satu atau lebih variabel dependen dan juga variabelel independen."
    },
    {
      "title": "Luas",
      "key": "luas",
      "image": "images/assets/luas.png",
      "detail":
          "Luas atau keluasan (bahasa Inggris: area) adalah besaran yang menyatakan ukuran dua dimensi (dwigatra) suatu bagian permukaan yang dibatasi dengan jelas."
    },
    {
      "title": "Volume",
      "key": "volum",
      "image": "images/assets/volum.jpg",
      "detail":
          "Volume atau bisa juga disebut kapasitas adalah penghitungan seberapa banyak ruang yang bisa ditempati dalam suatu objek."
    },
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Scaffold +',
            style: TextStyle(
              color: Color.fromARGB(255, 20, 158, 154),
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: const Image(
                image: AssetImage("images/assets/Profile-1.png"),
                width: 40,
              ),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 800 && constraints.maxHeight > 400) {
                return _buildWideHome(screenSize);
              } else if (constraints.maxWidth <= 800 &&
                  constraints.maxHeight > 400) {
                return _buildNormalHome(screenSize);
              } else {
                return CantAccessScreen(
                  mode: false,
                );
              }
            },
          ),
        ));
  }

  // Mobile User
  Widget _buildNormalHome(Size screenSize) {
    return Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Selesaikan permasalahan statistika anda dengan menjelajahi aplikasi Scaffold +",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              ListView(
                primary: false,
                shrinkWrap: true,
                children: Features.map((e) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ButtonCard(
                        detail: e["detail"],
                        image: e["image"],
                        screen: e["key"],
                        text: e["title"],
                      ));
                }).toList(),
              ),
            ],
          ),
        ));
  }

  // Web User
  Widget _buildWideHome(Size screenSize) {
    return Container(
      margin: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Selesaikan permasalahan statistika anda dengan menjelajahi aplikasi Scaffold +",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
              child: ListView(
            children: Features.map((e) {
              return Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ButtonCard(
                    detail: e["detail"],
                    image: e["image"],
                    screen: e["key"],
                    text: e["title"],
                  ));
            }).toList(),
          ))
        ],
      ),
    );
  }
}
