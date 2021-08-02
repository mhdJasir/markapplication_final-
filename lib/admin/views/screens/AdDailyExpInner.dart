import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/controller/DailyExpController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../main.dart';

class DailyExpinner extends StatefulWidget {
  final dalyexpanses, token;
  DailyExpinner({this.dalyexpanses, this.token});
  @override
  _DailyExpinnerState createState() => _DailyExpinnerState();
}

class _DailyExpinnerState extends StateMVC<DailyExpinner> {
  ImagePicker _picker = ImagePicker();
  DailyExpController _con;
  _DailyExpinnerState() : super(DailyExpController()) {
    _con = controller;
  }
  String statusval;
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

  TextEditingController addailywagescontrollr;
  TextEditingController adbalancecontrollr;
  TextEditingController adtotalamontcontrollr;
  TextEditingController adpaidamonutcontrollr;

  String paidval;
  @override
  void initState() {
    paidval = widget.dalyexpanses["paid_amount"].toString();
    addailywagescontrollr = TextEditingController(
        text: widget.dalyexpanses["salary_amount"].toString());
    adbalancecontrollr =
        TextEditingController(text: widget.dalyexpanses["balance"].toString());
    adpaidamonutcontrollr = TextEditingController(text: paidval);
    super.initState();
  }

  var totalamount;
  @override
  Widget build(BuildContext context) {
    totalamount = widget.dalyexpanses["salary_amount"] == null
        ? 0
        : widget.dalyexpanses["salary_amount"] +
                    widget.dalyexpanses["balance"] ==
                null
            ? 0
            : widget.dalyexpanses["balance"];
    adtotalamontcontrollr = TextEditingController(text: totalamount.toString());
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
          widget.dalyexpanses["project_name"].toString(),
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyApp.border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.dalyexpanses["project_name"].toString(),
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
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyApp.border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.dalyexpanses["emp_firstname"].toString(),
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
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: MyApp.border),
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
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: addailywagescontrollr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Daily Wages'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: adbalancecontrollr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Balance'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: adtotalamontcontrollr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Total Amount'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Form(
                key: _con.loginFormKey,
                child: TextFormField(
                  controller: adpaidamonutcontrollr,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      paidval = val;
                    });
                  },
                  validator: (value) =>
                      value.isEmpty || value == "null" ? '' : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Paid Amount'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                        msg: "Upload Image",
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
                        _con.updatedailyexp(
                            widget.dalyexpanses["exp_id"],
                            statusval,
                            widget.dalyexpanses["paid_amount"],
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
                    width: MediaQuery.of(context).size.width * 0.6,
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
