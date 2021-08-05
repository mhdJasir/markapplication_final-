import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdCashOnHand/AdMoneyhandAddScreen.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:intl/intl.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../main.dart';
import 'TransactionInnerPage.dart';

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
  int id;
  @override
  void initState() {
    _con.viewmoneytran(widget.token);
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
          "Cash Transfer",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: _con.loading == false
          ? ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionInner(
                                    widget.token,
                                    _con.viewMoneytrnsfer[index]["id"])));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 5),
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyApp.border)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, right: 15, left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    _con.viewMoneytrnsfer[index]
                                                ["emp_firstname"]
                                            .toString() +
                                        " " +
                                        _con.viewMoneytrnsfer[index]
                                                ["emp_lastname"]
                                            .toString(),
                                    style: b14W7),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _con.viewMoneytrnsfer[index]["remark"]
                                      .toString(),
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
                ),
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
                              builder: (context) => AdMoneyTransferAddscreen(
                                  token: widget.token)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff6DC066),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "Add Transaction",
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
