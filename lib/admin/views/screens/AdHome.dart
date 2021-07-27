import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdAttendence.dart';
import 'package:hrmarkgrp/admin/views/screens/AdCalRmrk.dart';
import 'package:hrmarkgrp/admin/views/screens/AdClient.dart';
import 'package:hrmarkgrp/admin/views/screens/AdDailyExpnce.dart';
import 'package:hrmarkgrp/admin/views/screens/AdDailyStatus.dart';
import 'package:hrmarkgrp/admin/views/screens/AdEmployeeTask.dart';
import 'package:hrmarkgrp/admin/views/screens/AdEmployees.dart';
import 'package:hrmarkgrp/admin/views/screens/AdHoliyClndr.dart';
import 'package:hrmarkgrp/admin/views/screens/AdLeaveRqst.dart';
import 'package:hrmarkgrp/admin/views/screens/AdMaterialRq.dart';
import 'package:hrmarkgrp/admin/views/screens/AdMoneyTrnsfer.dart';
import 'package:hrmarkgrp/admin/views/screens/AdNotification.dart';
import 'package:hrmarkgrp/admin/views/screens/AdPurchaseOrdr.dart';
import 'package:hrmarkgrp/admin/views/screens/Adinvoice.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/views/Screens/LoginScreen/login.dart';
import 'package:hrmarkgrp/user/views/widgets/icntxtwidget.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AdProjects.dart';
import 'AdSalary.dart';

class AdHome extends StatefulWidget {
  final token;
  AdHome({this.token});

  @override
  _AdHomeState createState() => _AdHomeState();
}

class _AdHomeState extends StateMVC<AdHome> {
  HomeController _con;

  _AdHomeState() : super(HomeController()) {
    _con = controller;
  }
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _con.task(widget.token);
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
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * .42,
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
                                                  AdNotificattionpage()));
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Center(
                              child: CircleAvatar(
                                maxRadius: 60,
                                minRadius: 50,
                                backgroundImage:
                                    AssetImage("assets/images/men.jpg"),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Mark Group", style: w20W5),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Admin", style: w15),
                          ],
                        )
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 14.0, left: 13),
                    //   child: Text(
                    //     "Task (" + _con.tskLevrqst.length.toString() + ")",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.grey[700]),
                    //   ),
                    // ), /////Taskk
                    // _con.tskLevrqst.length != 0
                    //     ? SizedBox(
                    //         height: MediaQuery.of(context).size.height * .18,
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //             top: 6.0,
                    //           ),
                    //           child: ListView.builder(
                    //             physics: BouncingScrollPhysics(),
                    //             shrinkWrap: true,
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: _con.tskLevrqst != null
                    //                 ? _con.tskLevrqst.length
                    //                 : 0,
                    //             itemBuilder: (context, index) {
                    //               final DateFormat frm =
                    //                   DateFormat('yyyy-MM-dd');
                    //               final String fromedatee = frm.format(
                    //                   DateTime.parse(
                    //                       _con.tskLevrqst[index]["from"]));
                    //               final String todatee = frm.format(
                    //                   DateTime.parse(
                    //                       _con.tskLevrqst[index]["to"]));
                    //               return Container(
                    //                 margin: const EdgeInsets.only(
                    //                     top: 9.0,
                    //                     right: 9.0,
                    //                     left: 9.0,
                    //                     bottom: 10),
                    //                 width:
                    //                     MediaQuery.of(context).size.width * .90,
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   borderRadius: BorderRadius.circular(15),
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                       color: Colors.grey[400],
                    //                       blurRadius: 1.1, // soften the shadow
                    //                       spreadRadius: 1.2, //extend the shadow
                    //                       offset: Offset(
                    //                         1.1, // Move to right 10  horizontally
                    //                         1.0, // Move to bottom 10 Vertically
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                       height: MediaQuery.of(context)
                    //                               .size
                    //                               .height *
                    //                           .18,
                    //                       width: MediaQuery.of(context)
                    //                               .size
                    //                               .width *
                    //                           .04,
                    //                       decoration: BoxDecoration(
                    //                           color: Color(0xff4a67b3),
                    //                           borderRadius: BorderRadius.only(
                    //                             topLeft: Radius.circular(15),
                    //                             bottomLeft: Radius.circular(15),
                    //                           )),
                    //                     ),
                    //                     Expanded(
                    //                       child: Padding(
                    //                         padding:
                    //                             const EdgeInsets.only(left: 10),
                    //                         child: Column(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment.start,
                    //                           children: <Widget>[
                    //                             Padding(
                    //                               padding:
                    //                                   const EdgeInsets.only(
                    //                                       right: 7),
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 children: <Widget>[
                    //                                   Text("Leave Request",
                    //                                       style: b18W5),
                    //                                   Text(
                    //                                     _con.tskLevrqst[index][
                    //                                             "emp_firstname"]
                    //                                         .toString(),
                    //                                     style: TextStyle(
                    //                                         color: Colors
                    //                                             .grey[500],
                    //                                         fontSize: 15),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             SizedBox(
                    //                               height: 10,
                    //                             ),
                    //                             Padding(
                    //                               padding:
                    //                                   const EdgeInsets.only(
                    //                                       right: 7),
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 children: [
                    //                                   Text(
                    //                                     fromedatee.toString() +
                    //                                         " to " +
                    //                                         todatee.toString(),
                    //                                     textAlign:
                    //                                         TextAlign.start,
                    //                                     style: TextStyle(
                    //                                         color: Colors
                    //                                             .grey[500],
                    //                                         fontSize: 15),
                    //                                   ),
                    //                                   Text(
                    //                                     _con.tskLevrqst[index]
                    //                                             ["leave_type"]
                    //                                         .toString(),
                    //                                     style: TextStyle(
                    //                                         color: Colors
                    //                                             .grey[500],
                    //                                         fontSize: 15),
                    //                                   )
                    //                                 ],
                    //                               ),
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 0,
                    //       ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 9.0, left: 9.0, top: 9.0, bottom: 8.5),
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
                              TableRow(children: [
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdAttendence(
                                                token: widget.token)));
                                    // pr.show();
                                  },
                                  title: "Attendence",
                                  icon: "assets/icons/imm.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdLeaveRqst(
                                                tokk: widget.token)));
                                  },
                                  icon: "assets/icons/luggage.png",
                                  width: 50,
                                  height: 40,
                                  title: "Leave Request",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MoneyTransfer(
                                                token: widget.token)));
                                  },
                                  title: "Money Transfer",
                                  icon: "assets/icons/schedule.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: [
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdDalyStatus(
                                                token: widget.token)));
                                  },
                                  title: "Daily Work Status",
                                  icon: "assets/icons/imm.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdDailyExpnce(
                                                tok: widget.token)));
                                  },
                                  title: "Daily Expense",
                                  icon: "assets/icons/stand.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdEmployeeTask(
                                                    toke: widget.token)));
                                  },
                                  title: "Employee Task",
                                  icon: "assets/icons/imm.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: [
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdMaterlReq(
                                                tok: widget.token)));
                                  },
                                  icon: "assets/icons/salary.png",
                                  width: 50,
                                  height: 40,
                                  title: "Material Request",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdPurchaseOrder(
                                                    token: widget.token)));
                                  },
                                  title: "Purchase Order",
                                  icon: "assets/icons/check-list.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Adcalremrk()));
                                  },
                                  title: "Calender",
                                  icon: "assets/icons/schedule.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: [
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdEmployees(
                                                tok: widget.token)));
                                  },
                                  title: "Employees",
                                  icon: "assets/icons/employee.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdSalary()));
                                  },
                                  title: "Salary",
                                  icon: "assets/icons/salary.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdClient(token: widget.token)));
                                  },
                                  title: "Clients",
                                  icon: "assets/icons/stand.png",
                                  width: 50,
                                  height: 40,
                                ),
                              ]),
                              TableRow(children: [
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdProjects(
                                                tokn: widget.token)));
                                  },
                                  icon: "assets/icons/imm.png",
                                  width: 50,
                                  height: 40,
                                  title: "Projects",
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Adinvoice(
                                                tokens: widget.token)));
                                  },
                                  title: "Invoice",
                                  icon: "assets/icons/stand.png",
                                  width: 50,
                                  height: 40,
                                ),
                                IconTxt(
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdHolydyclndr()));
                                  },
                                  icon: "assets/icons/suitcases.png",
                                  width: 50,
                                  height: 40,
                                  title: "Holiday Calender",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/men.jpg"),
                            backgroundColor: Colors.white,
                            radius: 45,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text("Mark Group", style: w17W8),
                        Text(
                          "Admin",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xff8495c9)),
              ),
              ListTile(
                title: Text(
                  "Attendence",
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
                          builder: (context) =>
                              AdAttendence(token: widget.token)));
                },
              ),
              ListTile(
                title: Text("Leave Request"),
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
                          builder: (context) =>
                              AdLeaveRqst(tokk: widget.token)));
                },
              ),
              ListTile(
                title: Text("Money Transfer"),
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
                          builder: (context) => MoneyTransfer(
                                token: widget.token,
                              )));
                },
              ),
              ListTile(
                title: Text(
                  "Daily Work Status",
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
                              AdDalyStatus(token: widget.token)));
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
                              AdDailyExpnce(tok: widget.token)));
                },
              ),
              ListTile(
                title: Text(
                  "Employee Task",
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
                              AdEmployeeTask(toke: widget.token)));
                },
              ),
              ListTile(
                title: Text(
                  "Material Request",
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
                              AdMaterlReq(tok: widget.token)));
                },
              ),
              ListTile(
                title: Text("Purchase Order"),
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
                          builder: (context) => AdPurchaseOrder(
                                token: widget.token,
                              )));
                },
              ),
              ListTile(
                title: Text("Calender"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Adcalremrk()));
                },
              ),
              ListTile(
                title: Text("Employee"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/employee.png",
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
                              AdEmployees(tok: widget.token)));
                },
              ),
              ListTile(
                title: Text("Salary"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/employee.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdSalary()));
                },
              ),
              ListTile(
                title: Text("Client"),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/icons/employee.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdClient(token: widget.token)));
                },
              ),
              ListTile(
                title: Text(
                  "Project",
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
                          builder: (context) =>
                              AdProjects(tokn: widget.token)));
                },
              ),
              ListTile(
                title: Text("Invoice"),
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
                              Adinvoice(tokens: widget.token)));
                },
              ),
              ListTile(
                title: Text("Holiday Calender"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdHolydyclndr()));
                },
              ),
              ListTile(
                title: Text(
                  "Logout",
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(
                    Icons.logout,
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.remove("tokenid");
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
