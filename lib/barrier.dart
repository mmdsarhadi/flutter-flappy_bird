import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final birheight;
  final birdwidth;
  final bool isThisBottomBarrier;
  final birrieX;

  MyBarrier({
    super.key,
    this.birheight,
    this.birdwidth,
    required this.isThisBottomBarrier,
    this.birrieX,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * birrieX + birdwidth) / (2 - birdwidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * birdwidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birheight / 2,
      ),
    );
  }
}
