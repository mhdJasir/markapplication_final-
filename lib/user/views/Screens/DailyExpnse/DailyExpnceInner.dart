import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyExpnceInner extends StatefulWidget {
  final dalyexp, token;
  DailyExpnceInner({this.dalyexp, this.token});
  @override
  _DailyExpnceInnerState createState() => _DailyExpnceInnerState();
}

class _DailyExpnceInnerState extends StateMVC<DailyExpnceInner> {
  DailyController _con;
  _DailyExpnceInnerState() : super(DailyController()) {
    _con = controller;
  }
  String statusval;
  ImagePicker _picker = ImagePicker();
  List status = [
    {
      "val": 1,
      "status": "Paid",
    },
    {
      "val": 0,
      "status": "Un Paid",
    },
  ];

  File _image;
  Future getCameraImage() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      Navigator.pop(context);
    });
  }

  Widget imagepickbottomsheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    getCameraImage();
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                  label: Text("Camera")),
              SizedBox(
                width: 20,
              ),
              TextButton.icon(
                  onPressed: () {
                    getGalleryImage();
                  },
                  icon: Icon(
                    Icons.image,
                    size: 30,
                  ),
                  label: Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }

  TextEditingController dailywagescontrollr;
  TextEditingController balancecontrollr;
  TextEditingController totalamontcontrollr;
  TextEditingController paidamonutcontrollr;

  String paidval;
  @override
  void initState() {
    paidval = widget.dalyexp["paid_amount"].toString();
    dailywagescontrollr =
        TextEditingController(text: widget.dalyexp["salary_amount"].toString());
    balancecontrollr =
        TextEditingController(text: widget.dalyexp["balance"].toString());
    paidamonutcontrollr = TextEditingController(text: paidval);
    super.initState();
  }

  Color border = Color(0xFFE9E9E9);
  Size get size => MediaQuery.of(context).size;
  Color main = Color(0xFFF6F6F6);
  var totalamount;
  @override
  Widget build(BuildContext context) {
    totalamount = widget.dalyexp["salary_amount"] == null
        ? 0
        : widget.dalyexp["salary_amount"] + widget.dalyexp["balance"] == null
            ? 0
            : widget.dalyexp["balance"];
    totalamontcontrollr = TextEditingController(text: totalamount.toString());
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
          widget.dalyexp["project_name"].toString(),
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.dalyexp["project_name"].toString(),
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
                    border: Border.all(width: 1, color: border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.dalyexp["emp_firstname"].toString(),
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
                height: 42,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: border),
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
                    items: status.map(
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
                          value: itmm["val"].toString(),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          statusval = val;
                        },
                      );
                    },
                    value: statusval,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(right: 9, left: 9),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: dailywagescontrollr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: border)),
                    labelText: 'Daily Wages'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: balancecontrollr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: border)),
                    labelText: 'Balance'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: TextFormField(
                controller: totalamontcontrollr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: border)),
                    labelText: 'Total Amount'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Form(
                key: _con.loginFormKey,
                child: TextFormField(
                  controller: paidamonutcontrollr,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      paidval = val;
                    });
                  },
                  validator: (value) =>
                      value.isEmpty || value == "null" ? '' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: border)),
                      labelText: 'Paid Amount'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => imagepickbottomsheet(context)));
                  },
                  child: CircleAvatar(
                    backgroundImage: _image == null
                        ? NetworkImage(
                            'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                        : FileImage(_image),
                    radius: 50.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (statusval == null) {
                      Fluttertoast.showToast(
                        msg: "Check status",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Colors.black,
                        fontSize: 16.0,
                      );
                    } else if (_image == null) {
                      Fluttertoast.showToast(
                        msg: "upload image",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 35,
                        backgroundColor: Colors.black,
                        fontSize: 16.0,
                      );
                    } else {
                      final FormState form = _con.loginFormKey.currentState;
                      if (!form.validate()) {
                      } else {
                        form.save();
                        _con.dailyexpnceupdate(
                            widget.dalyexp["exp_id"],
                            statusval,
                            paidval,
                            totalamount,
                            _image,
                            widget.token,
                            context);
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 50,
                    width: size.width * 0.7,
                    child: Text(
                      "Submit",
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
          ],
        ),
      ),
    );
  }
}
