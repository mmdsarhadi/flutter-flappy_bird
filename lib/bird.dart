import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final double bridwidth;
  final double bridheight;

  MyBird({this.birdY, required this.bridwidth, required this.bridheight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY + bridheight)/ ( 2 - bridheight)),
      width: 100,
      height: 100,
      child: Image.asset(
        'images/1.png',
        width: MediaQuery.of(context).size.height * bridwidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * bridheight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
