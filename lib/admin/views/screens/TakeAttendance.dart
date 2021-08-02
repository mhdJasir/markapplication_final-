import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/modules/loadingDialog.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class TakeAttendence extends StatefulWidget {
  final token;
  TakeAttendence({this.token});

  @override
  _TakeAttendenceState createState() => _TakeAttendenceState();
}

class _TakeAttendenceState extends StateMVC<TakeAttendence> {
  HomeController _con;

  _TakeAttendenceState() : super(HomeController()) {
    _con = controller;
  }
  Size get size => MediaQuery.of(context).size;
  DateTime firstDate;
  DateTime lastDate;
  DateTime selecteddate;
  String staff;
  List emppList = [];
  List<Map<String, dynamic>> attendanceList = [
    {"id": "1", "title": "Morning"},
    {"id": "2", "title": "Afternoon"}
  ];
  String attendance;
  @override
  void initState() {
    super.initState();
    _con.adattndace(widget.token);
    _getstaff();
    setState(() {
      selecteddate = DateTime.now();
    });
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
            "Add Attendance",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: MyApp.appBar,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                padding: EdgeInsets.only(right: 20, left: 20, top: 15),
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: MyApp.border),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  DateFormat('dd-MM-yyyy').format(selecteddate),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            _staff(emppList),
            selectAttendance(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    if (attendance != null && staff != null) {
                      print("take attendance");
                      _takeAttendance();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    height: 50,
                    width: size.width * 0.6,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selecteddate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selecteddate)
      setState(() {
        selecteddate = picked;
      });
  }

  Widget selectAttendance() {
    return Container(
        height: 55,
        margin: const EdgeInsets.only(right: 9, left: 20, top: 10),
        decoration: BoxDecoration(
          border: Border.all(color: MyApp.border),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Text(
                'Attendance',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            items: attendanceList.map(
              (itm) {
                return DropdownMenuItem<String>(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    child: new Text(
                      itm["title"].toString(),
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  value: itm["id"].toString(),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  attendance = val;
                },
              );
            },
            value: attendance,
          ),
        ));
  }

  Widget _staff(List getstaff) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: MyApp.border),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              'Staff',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
              fontSize: 15),
          items: getstaff.map(
            (itm) {
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    itm["empl_firstname"].toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: itm["id"].toString(),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                staff = val;
              },
            );
          },
          value: staff,
        ),
      ),
    );
  }

  Future _getstaff() async {
    NetworkUtils.token = widget.token;
    var res = await NetworkUtils.httpget(NetworkUtils.getemployees);
    if (res?.statusCode == 200) {
      var jsobj = jsonDecode(res.body);
      if (mounted) {
        setState(() {
          emppList = List.castFrom(jsobj["data"]);
        });
      }
    }
  }

  Future _takeAttendance() async {
    DialogBuilder(context).showLoadingDialog();
    var dateformat = DateFormat('dd-MM-yyyy').format(selecteddate);
    final String url = NetworkUtils.adminaddAttendance;
    var body = {
      "date": dateformat,
      "attendance": attendance,
      "employee": staff
    };
    var res = await NetworkUtils.httppost(url, body: body);
    DialogBuilder(context).hideOpenDialog();
    if (res.statusCode == 200) {
      var value = jsonDecode(res.body);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
        NotificationService().showNotification(
            "Attendance",
            "Attendance Added Successfully",
            "1",
            "Attendance",
            "Take Attendance");
      }
    }
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = [];

    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }

    return selectedDates;
  }
}
