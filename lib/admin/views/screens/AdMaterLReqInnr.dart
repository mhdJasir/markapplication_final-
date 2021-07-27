import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/controller/MatrialReqController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdMatrlReqInnr extends StatefulWidget {
  final getmaterialreqq;
  final token;
  AdMatrlReqInnr(this.getmaterialreqq, this.token);

  @override
  _AdMatrlReqInnrState createState() => _AdMatrlReqInnrState();
}

class _AdMatrlReqInnrState extends StateMVC<AdMatrlReqInnr> {
  MaterialControllr _con;
  _AdMatrlReqInnrState() : super(MaterialControllr()) {
    _con = controller;
  }

  String vendrr, item, status;

  TextEditingController item1qty = TextEditingController();
  Widget _vendor(List vendor) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey[400]),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              'Vendor',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
              fontSize: 15),
          items: vendor.map(
            (itmm) {
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    itmm["shop"].toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: itmm["id"].toString(),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                vendrr = val;
              },
            );
          },
          value: vendrr,
        ),
      ),
    );
  }

  List statuss = [
    {
      "idd": 1,
      "status": "Approved",
    },
    {
      "idd": 0,
      "status": "Declined",
    },
  ];

  @override
  void initState() {
    _con.getvendor(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.getmaterialreqq["project_name"].toString(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.getmaterialreqq["from_date"].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.getmaterialreqq["heading"].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.getmaterialreqq["project_name"].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, right: 9),
              child: _vendor(_con.vndorlist),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[400]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  child: Text(
                    widget.getmaterialreqq["description"].toString(),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Text(
                          'Status',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      items: statuss.map(
                        (itmm) {
                          return DropdownMenuItem<dynamic>(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              child: new Text(
                                itmm["status"].toString(),
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            value: itmm["idd"].toString(),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            status = val;
                          },
                        );
                      },
                      value: status,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            widget.getmaterialreqq["items"].length == 0
                ? Container(height: 0)
                : Container(
                    height: 300,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.getmaterialreqq["items"] != null
                            ? widget.getmaterialreqq["items"].length
                            : 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 9, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 42,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey[400]),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.getmaterialreqq["items"][index]
                                                ["product_name"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: 42,
                                    width: MediaQuery.of(context).size.width *
                                        0.328,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey[400]),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.getmaterialreqq["items"][index]
                                                  ["qty"]
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (vendrr == null || status == null) {
            Fluttertoast.showToast(
              msg: "Select The Field",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 35,
              backgroundColor: Colors.black,
              fontSize: 16.0,
            );
          } else {
            _con.updatematreqquset(
                vendrr,
                status,
                widget.getmaterialreqq["req_id"].toString(),
                widget.token,
                context);
          }

          // print("STATUS value " +statusvalue.toString());

          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdBottomtabs())) ;
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
          alignment: Alignment.bottomCenter,
          height: 50,
          padding: EdgeInsets.all(11),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Color(0xff4a67b3)),
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
