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
  final double _speed = 5;

  double _x = 0, _y = 0, _size = 0;

  double _step_x, _step_y, _angle;

  Color _color = Color.fromARGB(0, 0, 0, 0);

  bool _auto_change_color = false;

  bool _keep_move = true;

  double screenX, screenY;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      generateBall();
      changeColor();
      calculateMoveAngle();
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
      onDoubleTap: () {
        // 暂停/恢复移动
        _keep_move = !_keep_move;
      },
      onLongPress: () {
        // 自动改变小球颜色
        _auto_change_color = !_auto_change_color;
      },
    ));
  }

  // 开始移动
  void startMove() {
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      moveBall();
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
    _size = Random().nextDouble() * (screenY - screenX).abs();
    _x = Random().nextDouble() * screenX;
    _y = Random().nextDouble() * screenY;
  }

  // 计算小球初始移动角度（方向）
  void calculateMoveAngle() {
    _angle = Random().nextDouble() * 360;
    _step_x = sin(_angle) * _speed;
    _step_y = cos(_angle) * _speed;
  }

  // 带有便捷判定的小球移动
  void moveBall() {
    if (_keep_move) {
      if (_x >= screenX || _x <= 0) {
        _step_x = 0 - _step_x;
      }
      _x += _step_x;
      if (_y >= screenY || _y <= 0) {
        _step_y = 0 - _step_y;
      }
      _y += _step_y;
      if (_auto_change_color) {
        changeColor();
      }
    }
  }
}
