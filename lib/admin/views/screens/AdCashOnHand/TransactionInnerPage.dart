import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../main.dart';

class TransactionInner extends StatefulWidget {
  String token;
  int id;
  TransactionInner(this.token, this.id);
  @override
  _TransactionInnerState createState() => _TransactionInnerState();
}

class _TransactionInnerState extends State<TransactionInner> {
  Size get size => MediaQuery.of(context).size;
  var moneytransfer;

  apiCall() async {
    print("id  :" + widget.id.toString());
    var url = Uri.parse(NetworkUtils.money_transfer_view + "/${widget.id}");
    print("url :" + url.toString());
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + widget.token.toString()
    });
    print("status code : " + response.statusCode.toString());
    var data = json.decode(response.body);
    if (data["status"] == "1") {
      setState(() {
        moneytransfer = data["expanse"]["data"];
        print("data   :" + moneytransfer.toString());
      });
    }
  }

  @override
  void initState() {
    apiCall();
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
            "Transaction Details",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: MyApp.appBar,
        ),
        body: moneytransfer == null
            ? Center(child: CircularProgressIndicator())
            : moneytransfer.length == 0
                ? Center(child: Text("No Transactions Here"))
                : ListView.builder(
                    itemCount: moneytransfer.length,
                    itemBuilder: (context, index) {
                      var parsedDate = DateTime.parse(
                          moneytransfer[index]["start_day"].toString());
                      String date =
                          new DateFormat("yyyy-MM-dd").format(parsedDate);
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 15, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            moneytransfer[index]["project_name"]
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                          Text(date, style: TextStyle()),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            moneytransfer[index]["paid_amount"]
                                                    .toString() +
                                                "/-",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff496ab1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: size.width - 40,
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
  }
}
