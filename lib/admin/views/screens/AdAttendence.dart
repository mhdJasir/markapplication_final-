import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/TakeAttendance.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class AdAttendence extends StatefulWidget {
  final token;
  AdAttendence({this.token});

  @override
  _AdAttendenceState createState() => _AdAttendenceState();
}

class _AdAttendenceState extends StateMVC<AdAttendence> {
  HomeController _con;

  _AdAttendenceState() : super(HomeController()) {
    _con = controller;
  }
  DateTime firstDate;
  DateTime lastDate;
  DateTime selecteddate;
  String staff;
  List emppList = [];
  List allList = [];
  List allList2 = [];

  String attendance;
  @override
  void initState() {
    super.initState();
    _con.adattndace(widget.token);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TakeAttendence(token: widget.token);
            }));
          },
          child: Icon(Icons.add),
        ),
        body: _con.attndencelist != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // HorizontalCalendar(
                  //   isDateDisabled: (date) => date.weekday == DateTime.sunday,
                  //   spacingBetweenDates: 5,
                  //   weekDayTextStyle: TextStyle(
                  //     color: Colors.black,fontWeight: FontWeight.w800,
                  //   ),
                  //   onDateSelected: (time) {
                  //     setState(() {
                  //       selecteddate = time;
                  //     });
                  //     print("SELECTEDDAATEE $selecteddate");
                  //     print("Navigation HAPPENDDDDDDDDDD");
                  //   },
                  //
                  //   key: forceRender ? UniqueKey() : Key('Calendar'),
                  //   height: 80,
                  //   padding: EdgeInsets.all(16),
                  //   firstDate: firstDate,
                  //   lastDate: lastDate,
                  //   dateFormat: dateFormat,
                  //   weekDayFormat: weekDayFormat,
                  //   defaultDecoration: BoxDecoration(
                  //     color: defaultDecorationColor,
                  //     shape: defaultDecorationShape,
                  //     borderRadius: defaultDecorationShape == BoxShape.rectangle &&
                  //         isCircularRadiusDefault
                  //         ? BorderRadius.circular(15)
                  //         : null,
                  //   ),
                  //   selectedDecoration: BoxDecoration(
                  //     color: selectedDecorationColor,
                  //     shape: selectedDecorationShape,
                  //     borderRadius: selectedDecorationShape == BoxShape.rectangle &&
                  //         isCircularRadiusSelected
                  //         ? BorderRadius.circular(8)
                  //         : null,
                  //   ),
                  //   disabledDecoration: BoxDecoration(
                  //     color: disabledDecorationColor,
                  //     shape: disabledDecorationShape,
                  //     borderRadius: defaultDecorationShape == BoxShape.rectangle &&
                  //         isCircularRadiusSelected
                  //         ? BorderRadius.circular(8)
                  //         : null,
                  //   ),
                  //   // isDateDisabled: (date) => date.weekday == DateTime.sunday,
                  //   labelOrder: order.map(toLabelType).toList(),
                  //   minSelectedDateCount: minSelectedDateCount,
                  //   maxSelectedDateCount: maxSelectedDateCount,
                  //   initialSelectedDates: initialSelectedDates,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          //background color of box
                          BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 0.8, // soften the shadow
                            spreadRadius: 0.8, //extend the shadow
                            offset: Offset(
                              0.5, // Move to right 10  horizontally
                              0.5, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                                  "Attendence",
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
                                  percent: _con.attndencelist[
                                                  "present_percentage"]
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
                                  _con.attndencelist["presents"].toString(),
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
                                  _con.attndencelist["absents"].toString(),
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
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildContainer(clickedAll, true, false, false, "All"),
                        buildContainer(
                            clickedPresent, false, true, false, "Present"),
                        buildContainer(
                            clickedAbsent, false, false, true, "Absent"),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  clickedPresent
                      ? Container(
                          height: 500,
                          child: ListView.builder(
                            itemCount:
                                _con.attndencelist["presents_list"] != null
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
                                                _con.attndencelist[
                                                        "presents_list"][index]
                                                    ["emp_image"],
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
                              height: 500,
                              child: ListView.builder(
                                itemCount: _con.attndencelist["absents_list"] !=
                                        null
                                    ? _con.attndencelist["absents_list"].length
                                    : 0,
                                itemBuilder: (context, index) {
                                  return Column(
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
                                                    _con.attndencelist[
                                                            "absents_list"]
                                                        [index]["emp_image"],
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
                          : Container(), //Container(
                  //     height: 500,
                  //     child: ListView.builder(
                  //       itemCount: allList != null ? allList.length : 0,
                  //       itemBuilder: (context, index) {
                  //         return Column(
                  //           children: [
                  //             Container(
                  //               height: 50,
                  //               width: size.width - 30,
                  //               decoration: BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.circular(20),
                  //                   border: Border.all(
                  //                       color: Colors.grey[300])),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.start,
                  //                 children: [
                  //                   Padding(
                  //                     padding:
                  //                         const EdgeInsets.all(8.0),
                  //                     child: ClipRRect(
                  //                       borderRadius:
                  //                           BorderRadius.circular(60),
                  //                       child: Container(
                  //                         height: 30,
                  //                         width: 30,
                  //                         child: Image.network(
                  //                           allList[index]["emp_image"],
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     margin: EdgeInsets.all(5),
                  //                     child: Center(
                  //                         child: Row(
                  //                       children: [
                  //                         Text(allList[index]
                  //                             ["emp_firstname"]),
                  //                         Text(
                  //                             " ${allList[index]["emp_lastname"] == null ? "" : allList[index]["emp_lastname"]}")
                  //                       ],
                  //                     )),
                  //                   ),
                  //                   Spacer(),
                  //                   Container(
                  //                     margin: EdgeInsets.all(10),
                  //                     height: 30,
                  //                     width: 30,
                  //                     decoration: BoxDecoration(
                  //                       borderRadius:
                  //                           BorderRadius.circular(20),
                  //                       color: allList[index] = _con
                  //                                   .attndencelist[
                  //                               "presents_list"][index]
                  //                           ? Colors.green[300]
                  //                           : Colors.red[300],
                  //                     ),
                  //                     child: Center(
                  //                       child: allList[index] = _con
                  //                                   .attndencelist[
                  //                               "presents_list"][index]
                  //                           ? Text("P")
                  //                           : Text("A"),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 5,
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  // Widget selectAttendance() {
  //   return Container(
  //       height: 42,
  //       margin: const EdgeInsets.only(right: 9, left: 9, top: 10),
  //       decoration: BoxDecoration(
  //         border: Border.all(width: 1, color: Colors.grey[400]),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton(
  //           hint: Padding(
  //             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
  //             child: Text(
  //               'Attendance',
  //               style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 15),
  //             ),
  //           ),
  //           items: attendanceList.map(
  //             (itm) {
  //               return DropdownMenuItem<String>(
  //                 child: Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
  //                   child: new Text(
  //                     itm["title"].toString(),
  //                     style: TextStyle(fontSize: 15.0),
  //                   ),
  //                 ),
  //                 value: itm["id"].toString(),
  //               );
  //             },
  //           ).toList(),
  //           onChanged: (val) {
  //             setState(
  //               () {
  //                 attendance = val;
  //               },
  //             );
  //           },
  //           value: attendance,
  //         ),
  //       ));
  // }

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
              border: Border.all(color: clicked ? Colors.black : Colors.white),
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
