import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Mat_Req_Controllr.dart';
import 'package:hrmarkgrp/user/views/Screens/MatralRqst/MaterReqstAdd.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class MatrlRqst extends StatefulWidget {
  final tok;
  MatrlRqst({this.tok});
  @override
  _MatrlRqstState createState() => _MatrlRqstState();
}

class _MatrlRqstState extends StateMVC<MatrlRqst> {
  StaffMaterialReq _con;

  _MatrlRqstState() : super(StaffMaterialReq()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.stffgetmatreq(widget.tok);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Material Request",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: _con.loading == false
          ? ListView.builder(
              itemCount: _con.viewmaterialreqq != null
                  ? _con.viewmaterialreqq.length
                  : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (Context)=>AdMatrlReqInnr()));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 9, left: 9, top: 10),
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
                                Text(
                                    _con.viewmaterialreqq[index]["project_name"]
                                        .toString(),
                                    style: b14W7),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  _con.viewmaterialreqq[index]["heading"]
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
                                      _con.viewmaterialreqq[index]["from_date"]
                                          .toString(),
                                      style: b14W7,
                                    ),
                                    Text(
                                      _con.viewmaterialreqq[index]["status"]
                                                  .toString() ==
                                              "0"
                                          ? "Pending"
                                          : _con.viewmaterialreqq[index]
                                                          ["status"]
                                                      .toString() ==
                                                  "1"
                                              ? "Approved"
                                              : _con.viewmaterialreqq[index]
                                                              ["status"]
                                                          .toString() ==
                                                      "2"
                                                  ? "Declined"
                                                  : _con.viewmaterialreqq[index]
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
                              ]),
                        ),
                      ),
                    ));
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
                    builder: (context) => MaterialRqstAdd(token: widget.tok)));
          }),
    );
  }

  Future downloadFile(String url,
      {String path, Function onProgress(double p), Function onDone}) async {
    var request = http.Request('GET', Uri.parse(url));
    var response = http.Client().send(request);
    List<List<int>> chunks = [];
    int downloaded = 0;
    try {
      response.asStream().listen((http.StreamedResponse r) {
        r.stream.listen((List<int> chunk) {
          // Display percentage of completion
          onProgress(downloaded / r.contentLength);
          chunks.add(chunk);
          downloaded += chunk.length;
        }, onDone: () async {
          // Display percentage of completion
          onProgress(downloaded / r.contentLength);
          // Save the file
          if (mounted) {
            final Uint8List bytes = Uint8List(r.contentLength);
            int offset = 0;
            for (List<int> chunk in chunks) {
              bytes.setRange(offset, offset + chunk.length, chunk);
              offset += chunk.length;
            }
            File file = File(path);
            await file.writeAsBytes(bytes);
            onDone();
          }

          return;
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
