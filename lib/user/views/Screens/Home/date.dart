import 'package:flutter/material.dart';

import 'package:hrmarkgrp/user/controller/UserHomeController.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HolyCalndr extends StatefulWidget {
  final token;
  HolyCalndr({this.token});
  @override
  _HolyCalndrState createState() => _HolyCalndrState();
}

class _HolyCalndrState extends StateMVC<HolyCalndr> {
  UserHomeController _con;

  _HolyCalndrState() : super(UserHomeController()) {
    _con = controller;
  }
  // var formatted;
  // DateTime _currentDate;
  // String finalDate = '';
  // getCurrentDate(){
  //   var date = new DateTime.now().toString();
  //   var dateParse = DateTime.parse(date);
  //   final DateFormat formatter = DateFormat('MMMM');
  //   final String formatted = formatter.format(dateParse);
  //   setState(() {
  //     finalDate = formatted.toString() ;
  //   });
  //   print("$dateParse");
  //   print("$finalDate");
  //
  // }

  void initState() {
    _con.usrviewholy(widget.token);
    // getCurrentDate();
    // formatted="";

    super.initState();
  }
  // Widget calndrwidget() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 16.0),
  //     child: CalendarCarousel<Event>(
  //       onDayPressed: (DateTime date, List<Event> events) {
  //         this.setState(() => _currentDate = date);
  //         print("preeeeeeeeeeeeeeeee");
  //       },
  //       thisMonthDayBorderColor: Colors.grey,
  //       weekFormat: false,
  //       // markedDatesMap: _markedDateMap,
  //       height: 300.0,
  //
  //       selectedDateTime: _currentDate,/// null for not rendering any border, true for circular border, false for rectangular border
  //     ),
  //   );
  // }
  // final DateFormat formatter = DateFormat('MMMM');

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? SafeArea(
              child: Column(children: <Widget>[
                // Theme(
                //   data: theme,
                //   child: Container(
                //     padding: EdgeInsets.all(20),
                //     alignment: Alignment.center,
                //     color: Colors.white,
                //     child: ExpansionTile(
                //       title: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //         Text("September",style: TextStyle(
                //             fontWeight: FontWeight.w600,color: Colors.black,fontSize: 25
                //         ),),
                //           SizedBox(height: 5,),
                //           Text("2021",style: TextStyle(
                //             color: Colors.grey[500],fontWeight: FontWeight.w800
                //           ),)
                //         ],
                //       ),
                //       children: <Widget>[
                //         calndrwidget()
                //       ],
                //     ),
                //   ),
                // ),
                _con.userviewholylist != null
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: _con.userviewholylist != null
                                ? _con.userviewholylist.length
                                : 0,
                            itemBuilder: (context, index) {
                              var aaa = _con.userviewholylist[index]["date"];
                              DateTime bb = DateTime.parse(aaa); //
                              final DateFormat formatter = DateFormat('EEE');
                              final String formatted = formatter.format(bb);
                              print(formatted);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 6, left: 9, right: 9, top: 5),
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[400],
                                        blurRadius: 0.7, // soften the shadow
                                        spreadRadius: 0.5, //extend the shadow
                                        offset: Offset(
                                          0.3, // Move to right 10  horizontally
                                          0.3, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        right: 15,
                                        left: 15),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                bb.day.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 21),
                                              ),
                                              Text(
                                                formatted,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[600],
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          VerticalDivider(
                                            indent: 2,
                                            thickness: 1.3,
                                            color: Colors.grey[400],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _con.userviewholylist[index]
                                                          ["title"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  _con.userviewholylist[index]
                                                          ["date"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.grey[600],
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }))
                    : Container(
                        height: 0,
                      ),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
