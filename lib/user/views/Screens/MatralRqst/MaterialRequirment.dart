import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/user/controller/Mat_Req_Controllr.dart';
import 'package:hrmarkgrp/user/views/Screens/MatralRqst/MaterReqstAdd.dart';
import 'package:hrmarkgrp/user/views/Screens/MatralRqst/RequirementsDetails.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class MaterialRequirement extends StatefulWidget {
  final tok;
  MaterialRequirement({this.tok});
  @override
  _MaterialRequirementState createState() => _MaterialRequirementState();
}

class _MaterialRequirementState extends StateMVC<MaterialRequirement> {
  StaffMaterialReq _con;

  _MaterialRequirementState() : super(StaffMaterialReq()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.stffgetmatreq(widget.tok);
    super.initState();
  }

  Color main = Color(0xFFF6F6F6);
  Size get size => MediaQuery.of(context).size;
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
        backgroundColor: main,
      ),
      body: _con.loading == false
          ? ListView(children: [
              Container(
                height: size.height * 0.8,
                child: ListView.builder(
                  itemCount: _con.viewmaterialreqq != null
                      ? _con.viewmaterialreqq.length
                      : 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequirementsDetails()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 10),
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
                                    Text(
                                        _con.viewmaterialreqq[index]
                                                ["project_name"]
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
                                          _con.viewmaterialreqq[index]
                                                  ["from_date"]
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
                                                      : _con.viewmaterialreqq[
                                                                      index]
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
                                  AddMaterialRequirements(token: widget.tok)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff6DC066),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      height: 50,
                      width: size.width * 0.7,
                      child: Text(
                        "Add New Requirement",
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
