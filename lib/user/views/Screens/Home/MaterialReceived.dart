import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:hrmarkgrp/user/views/Screens/Home/MaterialReceivedAdd.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MaterialReceived extends StatefulWidget {
  final token;
  MaterialReceived({this.token});
  @override
  _MaterialReceivedState createState() => _MaterialReceivedState();
}

class _MaterialReceivedState extends StateMVC<MaterialReceived> {
  HomeController _con;
  _MaterialReceivedState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    _con.purchaseordr(widget.token);
    super.initState();
  }

  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
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
            "Material Received",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: main,
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
          padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
          child: Container(
            height: 109,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyApp.border)),
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
