import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/CalnderController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdholydyclndrAdd.dart';
import 'package:hrmarkgrp/main.dart';
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
          "Holiday Calender",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? SafeArea(
              child: _con.viewholydys != null
                  ? ListView(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
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
                                    border: MyApp.bord,
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
                                                  _con.viewholydys[index]
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
                                                  _con.viewholydys[index]
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
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdholydyclndrAdd()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xff6DC066),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                "Add New Holiday",
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
