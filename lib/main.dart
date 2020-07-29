import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ball.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BounceBall(),
    );
  }
}

class BounceBall extends StatefulWidget {
  @override
  _BounceBallState createState() => _BounceBallState();
}

class _BounceBallState extends State<BounceBall> {
  double _x=0, _y=0, _size=0;

  Color _color=Color.fromARGB(0, 0, 0, 0);

  Timer _runTimer;

  double screenX, screenY;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      generateBall();
      changeColor();
      startMove();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenX = MediaQuery.of(context).size.width;
    screenY = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GestureDetector(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(painter: Ball(_x, _y, _size, _color))),
      onTap: () {
        // 改变小球颜色
        changeColor();
      },
    ));
  }

  // 开始移动
  void startMove() {
    _runTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      _x += 1;
      _y += 1;
      setState(() {});
    });
  }

  // 改变小球颜色
  void changeColor() {
    _color = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  // 生成小球初始位置和大小
  void generateBall() {
    _x = Random().nextDouble() * screenX;
    _y = Random().nextDouble() * screenY;
    _size = Random().nextDouble() * (screenY - screenX).abs();
  }
}
