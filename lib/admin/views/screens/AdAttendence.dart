import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/TakeAttendance.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class AdAttendance extends StatefulWidget {
  final token;
  AdAttendance({this.token});

  @override
  _AdAttendanceState createState() => _AdAttendanceState();
}

class _AdAttendanceState extends StateMVC<AdAttendance> {
  HomeController _con;

  _AdAttendanceState() : super(HomeController()) {
    _con = controller;
  }
  DateTime firstDate;
  DateTime selecteddate;
  String staff;
  List preList = [];
  List absList = [];
  List<CombinedList> combinedList = [];
  var random = Random();
  lists() async {
    _con.adattndace(widget.token).then((value) {
      setState(() {
        absList = _con.attndencelist["absents_list"];
        preList = _con.attndencelist["presents_list"];
        for (var obj in _con.attndencelist["absents_list"]) {
          CombinedList list = CombinedList(
              obj["emp_firstname"], obj["emp_lastname"], "A", obj["emp_image"]);
          combinedList.add(list);
        }
        for (var obj in _con.attndencelist["presents_list"]) {
          CombinedList list = CombinedList(
              obj["emp_firstname"], obj["emp_lastname"], "P", obj["emp_image"]);
          combinedList.add(list);
        }
        combinedList.shuffle();
      });
    });
    print(_con.attndencelist);
  }

  String attendance;
  @override
  void initState() {
    super.initState();
    lists();
    setState(() {
      selecteddate = DateTime.now();
    });
  }

  Size get size => MediaQuery.of(context).size;
  bool clickedAll = true;
  bool clickedPresent = false;
  bool clickedAbsent = false;

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
          backgroundColor: MyApp.appBar,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, right: 9),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: MyApp.border)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 15, right: 15),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Attendance",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          new CircularPercentIndicator(
                            radius: 40.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 5.0,
                            percent: _con.attndencelist == null
                                ? 0
                                : _con.attndencelist["present_percentage"]
                                            .toDouble() >=
                                        1.0
                                    ? 1.0
                                    : _con.attndencelist["present_percentage"]
                                        .toDouble(),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.redAccent,
                            progressColor: Color(0xff4a67b3),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _con.attndencelist == null
                                ? ""
                                : _con.attndencelist["presents"].toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff4a67b3)),
                          ),
                          Text(
                            "Present",
                            style: g512W8,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _con.attndencelist == null
                                ? ""
                                : _con.attndencelist["absents"].toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.redAccent),
                          ),
                          Text(
                            "Absent",
                            style: g512W8,
                          )
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer(clickedAll, true, false, false, "All"),
                  buildContainer(clickedPresent, false, true, false, "Present"),
                  buildContainer(clickedAbsent, false, false, true, "Absent"),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _con.attndencelist == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                      SizedBox(
                        height: 400,
                      )
                    ],
                  )
                : (clickedPresent
                    ? Container(
                        height: 450,
                        child: ListView.builder(
                          itemCount: _con.attndencelist["presents_list"] != null
                              ? _con.attndencelist["presents_list"].length
                              : 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: size.width - 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Colors.grey[300])),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(
                                              "http://markbuilders.in/admin/${_con.attndencelist["presents_list"][index]["emp_image"]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: Center(
                                            child: Row(
                                          children: [
                                            Text(_con.attndencelist[
                                                    "presents_list"][index]
                                                ["emp_firstname"]),
                                            Text(
                                                " ${_con.attndencelist["presents_list"][index]["emp_lastname"] == null ? " " : _con.attndencelist["presents_list"][index]["emp_lastname"]}")
                                          ],
                                        )),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.green[300]),
                                        child: Center(child: Text("P")),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : clickedAbsent
                        ? Container(
                            height: 450,
                            child: ListView.builder(
                              itemCount: _con.attndencelist["absents_list"] !=
                                      null
                                  ? _con.attndencelist["absents_list"].length
                                  : 0,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: size.width - 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.grey[300])),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child: Image.network(
                                                  "http://markbuilders.in/admin/${_con.attndencelist["absents_list"][index]["emp_image"]}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            child: Center(
                                                child: Row(
                                              children: [
                                                Text(_con.attndencelist[
                                                        "absents_list"][index]
                                                    ["emp_firstname"]),
                                                Text(
                                                    " ${_con.attndencelist["absents_list"][index]["emp_lastname"] == null ? "" : _con.attndencelist["absents_list"][index]["emp_lastname"]}")
                                              ],
                                            )),
                                          ),
                                          Spacer(),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.red[300]),
                                            child: Center(child: Text("A")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        : clickedAll
                            ? Container(
                                height: 450,
                                child: ListView.builder(
                                  itemCount: combinedList != null
                                      ? combinedList.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: size.width - 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.grey[300])),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: Image.network(
                                                      "http://markbuilders.in/admin/${combinedList[index].image}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Text(combinedList[index]
                                                        .fname),
                                                    Text(
                                                        " ${combinedList[index].lname == null ? "" : combinedList[index].lname}")
                                                  ],
                                                )),
                                              ),
                                              Spacer(),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: combinedList[index]
                                                              .status ==
                                                          "A"
                                                      ? Colors.red[300]
                                                      : Colors.green[300],
                                                ),
                                                child: Center(
                                                  child: combinedList[index]
                                                              .status ==
                                                          "A"
                                                      ? Text("A")
                                                      : Text("P"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TakeAttendence(token: widget.token);
                    }));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 50,
                    width: size.width * 0.6,
                    child: Text(
                      "Add Attendance",
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
            SizedBox(
              height: 20,
            )
          ],
        ));
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

  Widget buildContainer(bool clicked, click1, click2, click3, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            clickedAll = click1;
            clickedPresent = click2;
            clickedAbsent = click3;
          });
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              border:
                  Border.all(color: clicked ? Color(0xFFE9E9E9) : Colors.white),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: clicked ? Colors.black : Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}

class CombinedList {
  String fname;
  String lname;
  String status;
  String image;
  CombinedList(this.fname, this.lname, this.status, this.image);
}
