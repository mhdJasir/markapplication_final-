import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdLeaveRqst extends StatefulWidget {
  final tokk;
  AdLeaveRqst({this.tokk});
  @override
  _AdLeaveRqstState createState() => _AdLeaveRqstState();
}

class _AdLeaveRqstState extends StateMVC<AdLeaveRqst> {
  HomeController _con;

  _AdLeaveRqstState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.viewlev(widget.tokk);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave Request",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: _con.loading == false
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        _con.viewleave != null ? _con.viewleave.length : 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 9, right: 9, top: 10, bottom: 5),
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
                                top: 15, bottom: 15, left: 15, right: 1),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Requests", style: b18W8),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          _con.viewleave[index]["emp_firstname"]
                                              .toString(),
                                          style: b13W8,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          _con.viewleave[index]["leave_type"]
                                              .toString(),
                                          style: b13W8,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            _con.viewleave[index]["from"]
                                                    .toString() +
                                                " - " +
                                                _con.viewleave[index]["to"]
                                                    .toString(),
                                            style: b13W8),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        MaterialButton(
                                          onPressed: () {
                                            _con
                                                .leavstatus(
                                                    widget.tokk,
                                                    "2",
                                                    _con.viewleave[index]["id"]
                                                        .toString(),
                                                    context)
                                                .then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          padding: EdgeInsets.all(2),
                                          shape: CircleBorder(),
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            _con
                                                .leavstatus(
                                              widget.tokk,
                                              "1",
                                              _con.viewleave[index]["id"]
                                                  .toString(),
                                              context,
                                            )
                                                .then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          padding: EdgeInsets.all(5),
                                          shape: CircleBorder(),
                                          color: Colors.green,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
