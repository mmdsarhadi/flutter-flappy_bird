import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velcoity = 3.5;
  double birdwidth = 0.1;
  double birheight = 0.1;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierwidth = 0.5;
  List<List<double>> barrierheight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velcoity * time;
      setState(() {
        birdY = initialPos - height;
      });
      if (birdIsDead()) {
        timer.cancel();

        _showDiolog();
        ();
      }
      moveMap();
      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);

    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDiolog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jumo() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdwidth &&
          barrierX[i] + barrierwidth >= -birdwidth &&
          (birdY <= -1 + barrierheight[i][0] ||
              birdY + birheight >= 1 - barrierheight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jumo : startGame,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Stack(
                  children: [
                    MyBird(
                      birdY: birdY,
                      bridheight: birheight,
                      bridwidth: birdwidth,
                    ),




                    MyBarrier(
                      birrieX: barrierX[0],
                      birdwidth: barrierwidth,
                      isThisBottomBarrier: false,
                      birheight: barrierheight[0][0],
                    ),
                    MyBarrier(
                      birrieX: barrierX[0],
                      birdwidth: barrierwidth,
                      isThisBottomBarrier: true,
                      birheight: barrierheight[0][1],
                    ),
                    MyBarrier(
                      birrieX: barrierX[1],
                      birdwidth: barrierwidth,
                      isThisBottomBarrier: false,
                      birheight: barrierheight[1][0],
                    ),
                    MyBarrier(
                      birrieX: barrierX[1],
                      birdwidth: barrierwidth,
                      isThisBottomBarrier: true,
                      birheight: barrierheight[1][1],
                    ),
                    Container(
                      alignment: Alignment(0, -0.5),
                      child: Text(
                        gameHasStarted ? '' : 'T A P  T O P  P L A Y',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
            ),
          ),
        ],
      )),
    );
  }
}
