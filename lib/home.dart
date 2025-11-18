import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  DateTime? chosenDateTime;     // 시간 나오는데
  late String currentDateTime;  // 현재시간 알려주는 변수
  late bool _isRunning;       // Timer가 작동하는지 아닌지 확인
  late Color color;      // 알람화면색 저장하는곳

  @override
  void initState() {
    currentDateTime = "";
    color = Colors.white;
    _isRunning = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) {
        timer.cancel();
      }
      addItem();
    },);
    super.initState();
  }

   addItem() {
    DateTime now = DateTime.now();
    currentDateTime =
        ("${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}:${now.second.toString().padLeft(2, "0")}");
    if (chosenDateTime != null &&
        _chosenItem(now) == _chosenItem(chosenDateTime!)) {
      color = color == Colors.amber ? Colors.pinkAccent : Colors.amber;
    } else {
      color = Colors.white;
    }
    setState(() {});
  }

  String _weekdayToString(int weekday){
    String dayToString = '';
    switch(weekday){
      case 1 : dayToString = "월";
      case 2 : dayToString = "화";
      case 3 : dayToString = "수";
      case 4 : dayToString = "목";
      case 5 : dayToString = "금";
      case 6 : dayToString = "토";
      case 7 : dayToString = "일";
    }
    return dayToString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  color,
      appBar: AppBar(
        title: Text('알람 정하기'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재시간 : $currentDateTime',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),
            Text(
              "선택시간 : ${chosenDateTime != null ? _chosenItem(chosenDateTime!) : "시간을 선택하세요!"}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )

          ],
        ),
      ),
    );
  } // build

  //---------------function---

  _chosenItem(DateTime now){
    String chosenDateTime = ("${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")} ${_weekdayToString(now.weekday)} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}");
    return chosenDateTime;

  }
} // class