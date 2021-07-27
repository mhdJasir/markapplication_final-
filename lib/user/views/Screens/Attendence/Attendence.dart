import 'package:flutter/material.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ntp/ntp.dart';

class Attendence extends StatefulWidget {
  final tokn;
  Attendence({this.tokn});
  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends StateMVC<Attendence> {
  UserHomeController _con;
  _AttendenceState() : super(UserHomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Color(0xff4a67b3),
        title: Text(
          "Attendance",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.45,
                margin: EdgeInsets.only(top: 20),
                child: OutlinedButton(
                  onPressed: () async {
                    var today = await NTP.now();
                    if (today.hour == 9) {
                      if (today.minute > 30) {
                        _con.stffaddattenedence(widget.tokn, today, 1, context);
                      }
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  child: Text("Morning"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 20),
                height: 60,
                width: MediaQuery.of(context).size.width * 0.45,
                child: OutlinedButton(
                  onPressed: () async {
                    var today = await NTP.now();
                    if (today.hour >= 13 && today.hour <= 14) {
                      if (today.minute > 30) {
                        _con.stffaddattenedence(widget.tokn, today, 2, context);
                      }
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  child: Text("Afternoon"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Text(
                "Morning Attendance  - 9 to 9:30 AM",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Afternoon Attendance  - 1 to 2:30 PM",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
