import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isResume = false;
  List lapsTime = [];
  int count = 0;
  bool isStart = false;
  bool isReset = false;
  int seconds = 0, minutes = 0, hours = 0;
  int prevSecondsLaps = 0, prevMinutesLaps = 0, prevHoursLaps = 0;
  String digitSecondsLaps = "00",
      digitMinutesLaps = "00",
      digitHoursLaps = "00";
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List overallTime = [];
  void stop() {
    timer!.cancel();
    setState(() {
      isReset = true;
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      prevSecondsLaps = 0;
      prevMinutesLaps = 0;
      prevHoursLaps = 0;
      isReset = false;
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      started = false;
      overallTime = [];
      lapsTime = [];
    });
  }

  void addoverallTime({required int h, required int m, required int s}) {
    int currentSeconds = s;
    int currentMinutes = m;
    int currentHours = h;
    int currentS = currentSeconds - prevSecondsLaps;
    int currentM = currentMinutes - prevMinutesLaps;
    int currentH = currentHours - prevHoursLaps;
    prevSecondsLaps = (currentSeconds);
    prevMinutesLaps = (currentMinutes);
    prevHoursLaps = (currentHours);
    digitSecondsLaps = seconds >= 10 ? "$currentS" : "0$currentS";
    digitMinutesLaps = minutes >= 10 ? "$currentM" : "0$currentM";
    digitHoursLaps = hours >= 10 ? "$currentH" : "0$currentH";

    String laps = '$digitHoursLaps : $digitMinutesLaps : $digitSecondsLaps';
    String allTime = '$digitHours : $digitMinutes : $digitSeconds';
    setState(() {
      lapsTime.add(laps);
      overallTime.add(allTime);
    });
  }

  void start() {
    started = true;
    if (started) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int _seconds = seconds + 1;
        int _minutes = minutes;
        int _hours = hours;
        if (_seconds > 59) {
          if (_minutes > 59) {
            _hours++;
            _minutes = 0;
          } else {
            _minutes++;
            _seconds = 0;
          }
        }
        setState(() {
          seconds = _seconds;
          minutes = _minutes;
          hours = _hours;
          digitSeconds = seconds >= 10 ? "$seconds" : "0$seconds";
          digitMinutes = minutes >= 10 ? "$minutes" : "0$minutes";
          digitHours = hours >= 10 ? "$hours" : "0$hours";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stop Watch App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 255, 193, 6),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 202, 57),
                  borderRadius: BorderRadius.circular(30)),
              height: 70,
              width: 250,
              child: Center(
                child: Text(
                  "$digitHours : $digitMinutes : $digitSeconds",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Lap",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Lap times",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Overall time",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: overallTime.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // SizedBox(
                                    //   width: 70,
                                    // ),
                                    Text((lapsTime[index]).toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                    // SizedBox(
                                    //   width: 100,
                                    // ),
                                    Text((overallTime[index]).toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Divider(
                                  color:const Color.fromARGB(255, 251, 202, 57),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
              height: 400,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white10,
                    spreadRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(120, 40)),
                    onPressed: () {
                      reset();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    )),
                IconButton(
                    onPressed: () {
                      addoverallTime(h: hours, m: minutes, s: seconds);
                      print(prevHoursLaps);
                      print(prevMinutesLaps);
                      print(prevSecondsLaps);
                    },
                    icon: Icon(
                      Icons.flag,
                      size: 30,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(120, 40)),
                    onPressed: () {
                      !started ? start() : stop();
                      setState(() {
                        count++;
                        // print('count =========== $count');
                        // if (count == 3) {
                        //   isReset = false;
                        //   isStart = false;
                        //   count--;
                        // } else if (count == 1) {
                        //   isStart = true;
                        //   flag = true;
                        // }  if (count == 2) {
                        //   isStart=true;
                        //   isReset = true;
                        // }
                      });
                    },
                    child: Text(
                      !started
                          ? isReset
                              ? "Resume"
                              : "Start"
                          : "Stop",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }
}
