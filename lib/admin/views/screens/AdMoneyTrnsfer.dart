import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdMoneyhandAddScreen.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:intl/intl.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class MoneyTransfer extends StatefulWidget {
  final token;
  MoneyTransfer({this.token});
  @override
  _MoneyTransferState createState() => _MoneyTransferState();
}

class _MoneyTransferState extends StateMVC<MoneyTransfer> {
  HomeController _con;

  _MoneyTransferState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.viewmoneytran(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Money Transfer",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: _con.loading == false
          ? ListView.builder(
              itemCount: _con.viewMoneytrnsfer != null
                  ? _con.viewMoneytrnsfer.length
                  : 0,
              itemBuilder: (context, index) {
                var parsedDate = DateTime.parse(
                    _con.viewMoneytrnsfer[index]["created_at"].toString());
                String convertedDate =
                    new DateFormat("yyyy-MM-dd").format(parsedDate);
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (Context)=>AdMatrlReqInnr(_con.getmaterialreqq[index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 15, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  convertedDate,
                                  style: b14W7,
                                ),
                                Text(
                                  _con.viewMoneytrnsfer[index]["amount"]
                                          .toString() +
                                      "/-",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff496ab1)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                _con.viewMoneytrnsfer[index]["emp_firstname"]
                                        .toString() +
                                    " " +
                                    _con.viewMoneytrnsfer[index]["emp_lastname"]
                                        .toString(),
                                style: b14W7),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              _con.viewMoneytrnsfer[index]["remark"].toString(),
                              style: b14W7,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdMoneyTransferAddscreen(token: widget.token)));
            print("flaoa");
          }),
    );
  }
}
