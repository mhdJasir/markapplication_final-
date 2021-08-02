import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/Adpurchseinner.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdPurchaseOrder extends StatefulWidget {
  final token;
  AdPurchaseOrder({this.token});
  @override
  _AdPurchaseOrderState createState() => _AdPurchaseOrderState();
}

class _AdPurchaseOrderState extends StateMVC<AdPurchaseOrder> {
  HomeController _con;

  _AdPurchaseOrderState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.purchaseordr(widget.token);
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
            "Materials Received",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: MyApp.appBar,
        ),
        body: _con.loading == false
            ? SafeArea(
                child: ListView.builder(
                  itemCount:
                      _con.purchseordr != null ? _con.purchseordr.length : 0,
                  itemBuilder: (context, index) {
                    // var parsedDate = DateTime.parse(_con.purchseordr[index]["purchase_date"].toString());
                    // String convertedDate = new DateFormat("dd-MM-yyyy").format(parsedDate);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Adpurchinner(
                                    _con.purchseordr[index], widget.token)));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 10),
                        child: Container(
                          height: 109,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: MyApp.bord),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        _con.purchseordr[index]
                                                    ["project_name"] !=
                                                null
                                            ? _con.purchseordr[index]
                                                    ["project_name"]
                                                .toString()
                                            : "",
                                        style: b14W7),
                                    Text(
                                        _con.purchseordr[index]
                                                    ["grand_total"] !=
                                                null
                                            ? _con.purchseordr[index]
                                                    ["grand_total"]
                                                .toString()
                                            : "",
                                        style: b14W7)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        _con.purchseordr[index]
                                                    ["payment_mode"] !=
                                                null
                                            ? _con.purchseordr[index]
                                                    ["payment_mode"]
                                                .toString()
                                            : "",
                                        style: b14W7),
                                    _con.purchseordr[index]["status"]
                                                .toString() ==
                                            "0"
                                        ? Text(
                                            "Pending",
                                            style: b14W7,
                                          )
                                        : _con.purchseordr[index]["status"]
                                                    .toString() ==
                                                "1"
                                            ? Text(
                                                "Approved",
                                                style: b14W7,
                                              )
                                            : _con.purchseordr[index]["status"]
                                                        .toString() ==
                                                    "2"
                                                ? Text(
                                                    "Declined",
                                                    style: b14W7,
                                                  )
                                                : _con.purchseordr[index]
                                                                ["status"]
                                                            .toString() ==
                                                        "3"
                                                    ? Text(
                                                        "Completed",
                                                        style: b14W7,
                                                      )
                                                    : Text(
                                                        "Pending",
                                                        style: b14W7,
                                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _con.purchseordr[index]
                                                  ["emp_firstname"] !=
                                              null
                                          ? _con.purchseordr[index]
                                                  ["emp_firstname"]
                                              .toString()
                                          : "",
                                      style: b14W7,
                                    ),
                                    Text(
                                        _con.purchseordr[index]
                                                    ["purchase_date"] ==
                                                null
                                            ? ""
                                            : _con.purchseordr[index]
                                                    ["purchase_date"]
                                                .toString(),
                                        style: b14W7)
                                  ],
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
