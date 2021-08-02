import 'dart:io';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/modules/loadingDialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/screens/AdMaterLReqInnr.dart';
import 'package:hrmarkgrp/admin/views/screens/AdMateriRqstAdd.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AdMaterlReq extends StatefulWidget {
  final tok;
  AdMaterlReq({this.tok});
  @override
  _AdMaterlReqState createState() => _AdMaterlReqState();
}

class _AdMaterlReqState extends StateMVC<AdMaterlReq> {
  HomeController _con;

  _AdMaterlReqState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.getmaterialreq(widget.tok);
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
          "Material Requirements",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemCount:
                _con.getmaterialreqq != null ? _con.getmaterialreqq.length : 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdMatrlReqInnr(
                              _con.getmaterialreqq[index], widget.tok)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: MyApp.bord),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 15, left: 15),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5,
                            right: 10,
                            child: Text(
                              _con.getmaterialreqq[index]["from_date"]
                                  .toString(),
                              style: b14W7,
                            ),
                          ),
                          _con.getmaterialreqq[index]["status"].toString() ==
                                  "1"
                              ? Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () async {
                                      var getdoc =
                                          await getApplicationDocumentsDirectory();
                                      var docPath = getdoc.path;
                                      var url = _con.getmaterialreqq[index]
                                              ["print"]
                                          .toString();
                                      var todown =
                                          File("$docPath/${basename(url)}.pdf")
                                              .path;
                                      if (!File(todown).existsSync()) {
                                        DialogBuilder(context)
                                            .showLoadingDialog();
                                        downloadFile(url, path: todown,
                                            onDone: () {
                                          DialogBuilder(context)
                                              .hideOpenDialog();
                                          OpenFile.open(todown);
                                        });
                                      } else {
                                        OpenFile.open(todown);
                                      }
                                    },
                                    child: Text(
                                      "Download PDF",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ))
                              : Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  _con.getmaterialreqq[index]["project_name"]
                                      .toString(),
                                  style: b14W7),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _con.getmaterialreqq[index]["heading"]
                                    .toString(),
                                style: b14W7,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _con.getmaterialreqq[index]["status"]
                                                .toString() ==
                                            "0"
                                        ? "Pending"
                                        : _con.getmaterialreqq[index]["status"]
                                                    .toString() ==
                                                "1"
                                            ? "Approved"
                                            : _con.getmaterialreqq[index]
                                                            ["status"]
                                                        .toString() ==
                                                    "2"
                                                ? "Declined"
                                                : _con.getmaterialreqq[index]
                                                                ["status"]
                                                            .toString() ==
                                                        "3"
                                                    ? "Completed"
                                                    : "Pending",
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
                            ],
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
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddMaterialRqstAdd(token: widget.tok)));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff6DC066),
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  "Add New Requirements",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future downloadFile(String url,
      {String path, Function onProgress(double p), Function onDone}) async {
    var httpClient = http.Client();
    var response = await httpClient.get(Uri.parse(url));
    var bytes = response.bodyBytes;
    File file = File('$path');
    await file.writeAsBytes(bytes);
    onDone();
  }
}
