import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  int _duration = 20 * 60;
  final CountDownController _controller = CountDownController();

  int _changeDuration() {
    if (_duration == 20 * 60) {
      return 5 * 60;
    }
    return 20 * 60;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.0),
              Expanded(
                child: CircularCountDownTimer(
                  duration: _duration,
                  initialDuration: 0,
                  controller: _controller,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  ringColor: Colors.orange,
                  ringGradient: null,
                  fillColor: Color.fromARGB(255, 255, 239, 229),
                  fillGradient: null,
                  backgroundColor: Colors.white,
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(178, 76, 175, 120),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 120.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 239, 229),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Study Time",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "20 minutes",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Pause Time",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "5 minutes",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            _button(
                iconW: Icon(Icons.not_started),
                onPressed: () => _controller.start()),
            const SizedBox(
              width: 10,
            ),
            _button(
                iconW: Icon(Icons.pause_circle),
                onPressed: () => _controller.pause()),
            const SizedBox(
              width: 10,
            ),
            _button(
                iconW: Icon(Icons.play_circle),
                onPressed: () => _controller.resume()),
            const SizedBox(
              width: 10,
            ),
            _button(
                iconW: Icon(Icons.compare_arrows),
                onPressed: () =>
                    _controller.restart(duration: _changeDuration()))
          ],
        ),
      ),
    );
  }

  Widget _button({required Icon iconW, VoidCallback? onPressed}) {
    return Expanded(
        child: ElevatedButton(
      child: iconW,
      // child: Text(
      //   title,
      //   style: const TextStyle(color: Colors.white),
      // ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(178, 76, 175, 120)),
      ),
      onPressed: onPressed,
    ));
  }
}
