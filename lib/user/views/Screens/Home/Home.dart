import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/Utils/global_variables.dart';
import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:hrmarkgrp/user/views/Screens/Attendence/attendence.dart';
import 'package:hrmarkgrp/user/views/Screens/DailyExpnse/DailyExpance.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/DailyWorkReport.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/CashOnHand.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/Notification.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/PaySlip.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/MaterialReceived.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/applyLeave.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/HolidayCalander.dart';
import 'package:hrmarkgrp/user/views/Screens/LoginScreen/login.dart';
import 'package:hrmarkgrp/user/views/Screens/MatralRqst/MaterialRequirment.dart';
import 'package:hrmarkgrp/user/views/widgets/icntxtwidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DailyConstructionReport/DailyConstructionReport.dart';

class Home extends StatefulWidget {
  Home({this.token});

  final String token;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  UserHomeController _con;

  _HomeState() : super(UserHomeController()) {
    _con = controller;
  }

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  getempdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      empImage = prefs.getString('empimag');
      empFirstName = prefs.getString('empfirstname');
      empLaststName = prefs.getString('emplastname');
      empDesignation = prefs.getString('empdesignation');
    });
  }

  @override
  void initState() {
    getempdetails();
    _con.stafftask(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff8595c8),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Color(0xfff2f3f5),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/bg-01.png"),
                                  fit: BoxFit.fill)),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.sort,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      _scaffoldkey.currentState.openDrawer();
                                    }),
                                IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.solidBell,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Notificattionpage()));
                                    }),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.002,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  empImage != null
                                      ? Center(
                                          child: CircleAvatar(
                                            radius: 65.0,
                                            backgroundColor: Colors.indigo[200],
                                            backgroundImage: NetworkImage(
                                                "http://markbuilders.in/admin/" +
                                                    empImage.toString()),
                                          ),
                                        )
                                      : Center(
                                          child: CircleAvatar(
                                            radius: 65.0,
                                            backgroundColor: Colors.white,
                                            child: Text(
                                              empFirstName
                                                  .toString()
                                                  .substring(0, 2)
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 34,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),

                                  // child:Image.network("http://markbuilders.in/admin/public/"+empImage.toString()),
                                  Text(
                                    empFirstName != null
                                        ? empFirstName.toString()
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),

                                  Text(
                                    empDesignation != null
                                        ? empDesignation.toString()
                                        : "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 8.0, bottom: 8.5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 1.1, // soften the shadow
                              spreadRadius: 1.2, //extend the shadow
                              offset: Offset(
                                1.1, // Move to right 10  horizontally
                                1.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 12, right: 12, bottom: 10),
                          child: Table(
                            border: TableBorder.symmetric(
                                inside: BorderSide(
                                    width: 1, color: Colors.grey[300])),
                            columnWidths: {
                              0: FractionColumnWidth(.3),
                              1: FractionColumnWidth(.3),
                              2: FractionColumnWidth(.3)
                            },
                            children: [
                              TableRow(children: <Widget>[
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Attendance(widget.token)));
                                  },
                                  title: "Attendance",
                                  icon: "assets/icons/imm.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DailyStatus(
                                                token: widget.token)));
                                  },
                                  title: "Daily Construction Rep",
                                  icon: "assets/icons/stand.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DailyExpnce(
                                                token: widget.token)));
                                  },
                                  title: "Daily Expense",
                                  icon: "assets/icons/stand.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: <Widget>[
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CashOnHand(tok: widget.token)));
                                  },
                                  icon: "assets/icons/salary.png",
                                  width: 50,
                                  height: 40,
                                  title: "Cash On Hand",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MaterialRequirement(
                                                    tok: widget.token)));
                                  },
                                  icon: "assets/icons/salary.png",
                                  width: 50,
                                  height: 40,
                                  title: "Material Requirements",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MaterialReceived(
                                                  token: widget.token,
                                                )));
                                  },
                                  title: "Material Received",
                                  icon: "assets/icons/check-list.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: <Widget>[
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ApplyLeavePage(
                                                  token: widget.token,
                                                )));
                                  },
                                  icon: "assets/icons/luggage.png",
                                  width: 50,
                                  height: 40,
                                  title: "Apply Leave",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DailyWorkReport(
                                                    tok: widget.token)));
                                  },
                                  title: "Daily Work Report",
                                  icon: "assets/icons/schedule.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaySlip()));
                                  },
                                  icon: "assets/icons/check-list.png",
                                  width: 50,
                                  height: 40,
                                  title: "Salary Slip",
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          drawer: Drawer(
              child: ListView(
            children: [
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "http://markbuilders.in/admin/" +
                                    empImage.toString()),
                            backgroundColor: Colors.white,
                            radius: 45,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          empFirstName != null ? empFirstName.toString() : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          empDesignation != null
                              ? empDesignation.toString()
                              : "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xff8495c9)),
              ),
              ListTile(
                title: Text(
                  "Attendance",
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/imm.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Attendance(widget.token)));
                },
              ),
              ListTile(
                title: Text(
                  "Daily Expense",
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/stand.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DailyExpnce(token: widget.token)));
                },
              ),
              ListTile(
                title: Text(
                  "Material Requirements",
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/salary.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MaterialRequirement(tok: widget.token)));
                },
              ),
              ListTile(
                title: Text("Apply Leave"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/luggage.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ApplyLeavePage(
                                token: widget.token,
                              )));
                },
              ),
              ListTile(
                title: Text("Holiday Calender"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/suitcases.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HolyCalndr(
                                token: widget.token,
                              )));
                },
              ),
              ListTile(
                title: Text("Material Received"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/check-list.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MaterialReceived(
                                token: widget.token,
                              )));
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(
                    Icons.logout,
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () async {
                  var prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
