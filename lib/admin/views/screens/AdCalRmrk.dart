import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/CalnderController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdRemark.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class Adcalremrk extends StatefulWidget {
  @override
  _AdcalremrkState createState() => _AdcalremrkState();
}

class _AdcalremrkState extends StateMVC<Adcalremrk> {
  CalendersControllr _con;

  _AdcalremrkState() : super(CalendersControllr()) {
    _con = controller;
  }

  void initState() {
    _con.viecalnder();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
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
          "Events",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? SafeArea(
              child: _con.viewcalnderr != null
                  ? ListView(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                            itemCount: _con.viewcalnderr != null
                                ? _con.viewcalnderr.length
                                : 0,
                            itemBuilder: (context, index) {
                              var aaa = _con.viewcalnderr[index]["event_date"];
                              DateTime bb = DateTime.parse(aaa); //
                              final DateFormat formatter = DateFormat('EEE');
                              // print(formatter);
                              final DateFormat vv = DateFormat('yyyy-MM-dd');
                              final String formatted = formatter.format(bb);
                              final String datee = vv.format(bb);
                              print(datee); // something like 2013-04-20

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: MyApp.border),
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
                                                  _con.viewcalnderr[index]
                                                          ["event_name"]
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
                                                  datee.toString(),
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
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdRemark()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xff6DC066),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                "Add Event",
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
                    ])
                  : Container(
                      height: 0,
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
