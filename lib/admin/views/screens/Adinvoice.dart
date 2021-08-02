import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Adinvoice extends StatefulWidget {
  final tokens;
  Adinvoice({this.tokens});
  @override
  _AdinvoiceState createState() => _AdinvoiceState();
}

class _AdinvoiceState extends StateMVC<Adinvoice> {
  HomeController _con;

  _AdinvoiceState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.getinvoice(widget.tokens);
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
            "Invoice",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: MyApp.appBar,
        ),
        backgroundColor: Color(0xfff5f6f8),
        body: _con.loading == false
            ? ListView.builder(
                itemCount:
                    _con.getinvoicea != null ? _con.getinvoicea.length : 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpDetails()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 6, bottom: 1),
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
                              top: 15, bottom: 15, right: 15, left: 15),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Image.network(
                                        "http://markbuilders.in/admin/public/" +
                                            _con.getinvoicea[index]["image"]
                                                .toString(),
                                        width: 47,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            _con.getinvoicea[index]["company"]
                                                .toString(),
                                            style: w816),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          _con.getinvoicea[index]["status"]
                                                      .toString() ==
                                                  "1"
                                              ? "Partially Paid"
                                              : _con.getinvoicea[index]
                                                              ["status"]
                                                          .toString() ==
                                                      "2"
                                                  ? "Paid"
                                                  : _con.getinvoicea[index]
                                                                  ["status"]
                                                              .toString() ==
                                                          "0"
                                                      ? "Unpaid"
                                                      : "Unpaid",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: _con.getinvoicea[index]
                                                              ["status"]
                                                          .toString() ==
                                                      "1"
                                                  ? Colors.orange[800]
                                                  : _con.getinvoicea[index]
                                                                  ["status"]
                                                              .toString() ==
                                                          "2"
                                                      ? Colors.green[600]
                                                      : _con.getinvoicea[index]
                                                                      ["status"]
                                                                  .toString() ==
                                                              "0"
                                                          ? Colors.red[700]
                                                          : Colors.red[700]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        _con.getinvoicea[index]["grand_total"]
                                                .toString() +
                                            "/-",
                                        style: b10W7),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        _con.getinvoicea[index]["invoice_date"]
                                            .toString(),
                                        style: b10W7),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
