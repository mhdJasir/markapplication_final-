import 'package:flutter/material.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/leaveRequest.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ApplyLeavePage extends StatefulWidget {
  final String token;
  ApplyLeavePage({this.token});
  @override
  _ApplyLeavePageState createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends StateMVC<ApplyLeavePage> {
  UserHomeController _con;
  _ApplyLeavePageState() : super(UserHomeController()) {
    _con = controller;
  }
  bool clickedAll = true;
  bool clickedPending = false;
  bool clickedApprove = false;
  Color textfield = Colors.grey[200];
  var approved = [];
  var pending = [];
  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
  lists() async {
    _con.viewallstffleave(widget.token).then((value) {
      print(_con.allleave.toString());
      for (int i = 0; i < _con.allleave.length; i++) {
        if (_con.allleave[i]["status"] == "1") {
          print("status 1 :" + _con.allleave[i]["status"] == "1".toString());
          approved.add(_con.allleave[i]);
          print("approved :" + approved.toString());
        }
        if (_con.allleave[i]["status"] == "0") {
          pending.add(_con.allleave[i]);
        }
      }
      print("approved : " + approved.toString());
    });
  }

  @override
  void initState() {
    lists();
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
          "Applied Leave Requests",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 40,
            width: size.width - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(clickedAll, true, false, false, "All"),
                buildContainer(clickedPending, false, true, false, "Approved"),
                buildContainer(clickedApprove, false, false, true, "Pending"),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.68,
            child: clickedAll
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: _con.allleave != null ? _con.allleave.length : 0,
                    itemBuilder: (context, index) {
                      final DateFormat formatter =
                          new DateFormat('dd MMM yyyy');
                      String fromdate = formatter
                          .format(DateTime.parse(_con.allleave[index]["from"]));
                      String todate = formatter
                          .format(DateTime.parse(_con.allleave[index]["to"]));
                      return Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: 100,
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(color: Color(0xFFE9E9E9))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      _con.allleave[index]["leave_reason"]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      )),
                                  _con.allleave[index]["status"].toString() ==
                                          "1"
                                      ? Container(
                                          height: 20,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFFE9E9E9)),
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text("Approved",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white)),
                                          ),
                                        )
                                      : _con.allleave[index]["status"]
                                                  .toString() ==
                                              "2"
                                          ? Container(
                                              height: 20,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFFE9E9E9)),
                                                  color: Color(0xffd7334c),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text("Decline",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white)),
                                              ),
                                            )
                                          : _con.allleave[index]["status"]
                                                      .toString() ==
                                                  "0"
                                              ? Container(
                                                  height: 20,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFE9E9E9)),
                                                      color: Color(0xFFF49C16),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text("Pending",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                )
                                              : Container(
                                                  height: 20,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(
                                                              0xFFE9E9E9)),
                                                      color: Color(0xFFF49C16),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text("Pending",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    fromdate + " - " + todate,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _con.allleave[index]["leave_type"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffE2E2E2),
                                      ),
                                      child: Center(
                                          child: Text(_con.allleave[index]
                                                  ["noof_days"]
                                              .toString()))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : clickedApprove
                    ? ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: pending.length != null ? pending.length : 0,
                        itemBuilder: (context, index) {
                          final DateFormat formatter =
                              new DateFormat('dd MMM yyyy');
                          String fromdate = formatter
                              .format(DateTime.parse(pending[index]["from"]));
                          String todate = formatter
                              .format(DateTime.parse(pending[index]["to"]));
                          return Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            height: 100,
                            width: size.width - 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE9E9E9))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, left: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          pending[index]["leave_reason"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          )),
                                      Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFE9E9E9)),
                                            color: Color(0xFFF49C16),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text("Pending",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        fromdate + " - " + todate,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        pending[index]["leave_type"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffE2E2E2),
                                          ),
                                          child: Center(
                                              child: Text(pending[index]
                                                      ["noof_days"]
                                                  .toString()))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    : clickedPending
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount:
                                approved.length != null ? approved.length : 0,
                            itemBuilder: (context, index) {
                              final DateFormat formatter =
                                  new DateFormat('dd MMM yyyy');
                              String fromdate = formatter.format(
                                  DateTime.parse(approved[index]["from"]));
                              String todate = formatter.format(
                                  DateTime.parse(approved[index]["to"]));
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                height: 100,
                                width: size.width - 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFFE9E9E9))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              approved[index]["leave_reason"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                          Container(
                                            height: 20,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xFFE9E9E9)),
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text("Approved",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            fromdate + " - " + todate,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            approved[index]["leave_type"],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Color(0xffE2E2E2),
                                              ),
                                              child: Center(
                                                  child: Text(approved[index]
                                                          ["noof_days"]
                                                      .toString()))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : Container(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LeaveRequest(widget.token);
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
                    "Apply For Leave",
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
      ),
    );
  }

  Widget buildContainer(bool clicked, click1, click2, click3, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            clickedAll = click1;
            clickedPending = click2;
            clickedApprove = click3;
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

class BuildList {}
