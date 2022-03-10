import 'package:flutter/material.dart';
import '../screens/input_data_screen.dart';
import '../screens/calculate_screen.dart';

// Card Class
class ButtonCard extends StatelessWidget {
  String image;
  String text;
  String detail;
  String screen;

  ButtonCard(
      {Key? key,
      required this.image,
      required this.text,
      required this.detail,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(detail),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: GestureDetector(
                onTap: () {
                  if (screen == "regresilinear") {
                    Navigator.of(context).push(_createRoute1());
                  } else if (screen == "luas") {
                    Navigator.of(context).push(_createRoute2("Luas"));
                  } else if (screen == "volum") {
                    Navigator.of(context).push(_createRoute2("Volume"));
                  }
                },
                child: Container(
                  height: 45,
                  color: const Color.fromARGB(255, 20, 158, 154),
                  child: Center(
                      child: Text(
                    "Hitung $text sekarang!",
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Route screen to Regresi Linear
Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const InputDataScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

//Route screen to Calculation
Route _createRoute2(String screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        CalculationScreen(Methode: screen),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
