import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ntp/ntp.dart';

class Attendance extends StatefulWidget {
  String token;
  Attendance(this.token);
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends StateMVC<Attendance> {
  UserHomeController _con;
  _AttendanceState() : super(UserHomeController()) {
    _con = controller;
  }

  Color main = Color(0xFFF6F6F6);
  String formattedDate;
  String formattedTime;
  var today;
  Future timeRange() async {
    today = await NTP.now();
    setState(() {});
  }

  Future geTime() async {
    DateTime now = DateTime.now();
    final DateFormat dateFormatter = DateFormat('dd MMM yyyy');
    final DateFormat timeFormatter = DateFormat('hh : mm');
    setState(() {
      formattedDate = dateFormatter.format(now);
      formattedTime = timeFormatter.format(now);
    });
  }

  @override
  void initState() {
    timeRange();
    geTime();
    Timer.periodic(Duration(minutes: 1), (Timer t) => geTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF545454),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Attendance",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                formattedTime,
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                "Morning Attendance  - 9:00 to 9:10 AM",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Afternoon Attendance  - 1:30 to 1:45 PM",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: today.hour == 9 && today.minute <= 10
                    ? () async {
                        await _con.stffaddattenedence(
                            widget.token, today, 1, context);
                      }
                    : today.hour == 13 &&
                            today.minute >= 30 &&
                            today.minute <= 45
                        ? () async {
                            await _con.stffaddattenedence(
                                widget.token, today, 2, context);
                          }
                        : null,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: today.hour == 9 && today.minute <= 10
                          ? Colors.blue
                          : today.hour == 13 &&
                                  today.minute >= 30 &&
                                  today.minute <= 45
                              ? Colors.green
                              : today.hour >= 13 && today.minute > 45
                                  ? Colors.green[200]
                                  : today.hour >= 14
                                      ? Colors.green[200]
                                      : Colors.blue[200]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        today.hour == 9 && today.minute <= 10
                            ? Text(
                                "Morning",
                                style: TextStyle(color: Colors.white),
                              )
                            : today.hour >= 13
                                ? Text("Evening",
                                    style: TextStyle(color: Colors.white))
                                : Text(
                                    "Morning",
                                    style: TextStyle(color: Colors.white),
                                  )
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
