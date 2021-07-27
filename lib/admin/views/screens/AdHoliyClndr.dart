import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/CalnderController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdholydyclndrAdd.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdHolydyclndr extends StatefulWidget {
  @override
  _AdHolydyclndrState createState() => _AdHolydyclndrState();
}

class _AdHolydyclndrState extends StateMVC<AdHolydyclndr> {
  CalendersControllr _con;

  _AdHolydyclndrState() : super(CalendersControllr()) {
    _con = controller;
  }

  void initState() {
    _con.viwhlyday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Holiday Calender",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? SafeArea(
              child: _con.viewholydys != null
                  ? ListView.builder(
                      itemCount: _con.viewholydys != null
                          ? _con.viewholydys.length
                          : 0,
                      itemBuilder: (context, index) {
                        var aaa = _con.viewholydys[index]["date"];
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
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.7, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, right: 15, left: 15),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _con.viewholydys[index]["title"]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _con.viewholydys[index]["date"]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
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
                      })
                  : Container(
                      height: 0,
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff496ab1),
          child: Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdholydyclndrAdd()));
            print("flaoa");
          }),
    );
  }
}
