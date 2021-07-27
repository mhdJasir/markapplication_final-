import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:hrmarkgrp/user/views/Screens/DailyExpnse/DailyExpnceInner.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyExpnce extends StatefulWidget {
  final token;
  DailyExpnce({this.token});
  @override
  _DailyExpnceState createState() => _DailyExpnceState();
}

class _DailyExpnceState extends StateMVC<DailyExpnce> {
  DailyController _con;

  _DailyExpnceState() : super(DailyController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.getviewdailyexpance(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Daily Expense",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff496ab1),
        ),
        body: ListView.builder(
          itemCount:
              _con.dilyexpnceview != null ? _con.dilyexpnceview.length : 0,
          itemBuilder: (context, index) {
            var parsedDate = DateTime.parse(
                _con.dilyexpnceview[index]["created_at"].toString());
            String date = new DateFormat("dd-MM-yyyy").format(parsedDate);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DailyExpnceInner(
                              dalyexp: _con.dilyexpnceview[index],
                              token: widget.token,
                            )));
              },
              child: Container(
                height: 130,
                margin: const EdgeInsets.only(
                    top: 5.0, right: 9.0, left: 9.0, bottom: 5),
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
                      top: 3, bottom: 3, right: 15, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _con.dilyexpnceview[index]["created_at"] != null
                              ? Text(date, style: b14W7)
                              : Container(),
                          _con.dilyexpnceview[index]["status"] == 0
                              ? Text("Un Paid", style: b14W7)
                              : _con.dilyexpnceview[index]["status"] == 1
                                  ? Text("Paid", style: b14W7)
                                  : Text("Un Paid", style: b14W7),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _con.dilyexpnceview[index]["project_name"] != null
                            ? _con.dilyexpnceview[index]["project_name"]
                                .toString()
                            : "",
                        style: b14W7,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          _con.dilyexpnceview[index]["emp_firstname"] != null
                              ? _con.dilyexpnceview[index]["emp_firstname"]
                                  .toString()
                              : "",
                          style: b14W7),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              _con.dilyexpnceview[index]["salary_amount"] !=
                                      null
                                  ? _con.dilyexpnceview[index]["salary_amount"]
                                      .toString()
                                  : "",
                              style: b14W7),
                          Text(
                              _con.dilyexpnceview[index]["paid_amount"] != null
                                  ? _con.dilyexpnceview[index]["paid_amount"]
                                      .toString()
                                  : "",
                              style: b14W7),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
