import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/PurchaseOrdrInnr.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PurchaseOrder extends StatefulWidget {
  final token;
  PurchaseOrder({this.token});
  @override
  _PurchaseOrderState createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends StateMVC<PurchaseOrder> {
  HomeController _con;
  _PurchaseOrderState() : super(HomeController()) {
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
          title: Text(
            "Purchase Order",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff496ab1),
        ),
        body: SafeArea(
          child: ListView(
            children: _lists(),
          ),
        ));
  }

  List<Widget> _lists() {
    List<Widget> list = [];
    for (var i = 0; i < _con.purchseordr.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PurchaseOrderInner()));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
          child: Container(
            height: 109,
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_con.purchseordr[i]["project_name"], style: b14W7),
                      Text(_con.purchseordr[i]["grand_total"] ?? "0",
                          style: b14W7)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_con.purchseordr[i]["payment_mode"] ?? "",
                          style: b14W7),
                      Text(
                        "Approved",
                        style: b14W7,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _con.purchseordr[i]["emp_firstname"],
                        style: b14W7,
                      ),
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
      ));
    }
    return list;
  }
}
