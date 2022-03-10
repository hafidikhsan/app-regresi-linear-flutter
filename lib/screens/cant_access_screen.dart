import 'package:flutter/material.dart';

class CantAccessScreen extends StatelessWidget {
  bool mode;
  //const CantAccessScreen({Key? key, required this.mode}) : super(key: key);

  CantAccessScreen({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
            child: const Image(
              image: AssetImage("images/assets/sad.png"),
            ),
          ),
          Text(
            "Maaf, anda tidak dapat mengakses Aplikasi, karena ukuran tinggi layar anda kurang dari 500px",
            style: TextStyle(
              color: (mode) ? Colors.white : Colors.black,
              fontSize: 21,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
