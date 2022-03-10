import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class CustomButtonHome extends StatelessWidget {
  const CustomButtonHome({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(_createRoute());
        },
        child: Container(
          height: 45,
          color: const Color.fromARGB(255, 20, 158, 154),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}

//Route screen to Home Screen
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
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
