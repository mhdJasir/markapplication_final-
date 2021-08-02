import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ConstructionReportEdit extends StatefulWidget {
  final token;
  ConstructionReportEdit({this.token});
  @override
  _ConstructionReportEditState createState() => _ConstructionReportEditState();
}

class _ConstructionReportEditState extends StateMVC<ConstructionReportEdit> {
  DailyController _con;
  _ConstructionReportEditState() : super(DailyController()) {
    _con = controller;
  }
  String currntdate;
  String project;
  var employ;
  ImagePicker _imagePicker = ImagePicker();
  var nameList = [];
  var NewList;
  Color main = Color(0xFFF6F6F6);
  File _image;
  Size get size => MediaQuery.of(context).size;
  getImageFile(ImageSource source) async {
    var image = await _imagePicker.pickImage(source: source);
    setState(() {
      _image = File(image.path);
    });
  }

  String currentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    setState(() {
      currntdate = formatter.format(now);
    });
  }

  @override
  void initState() {
    currentdate();
    _con.getproject(widget.token);
    _con.getstaff(widget.token);
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
          "Daily Construction report",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
    );
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
              ElevatedButton.icon(
                  onPressed: () {
                    getImageFile(ImageSource.camera)
                        .whenComplete(() => Navigator.pop(context));
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                  label: Text("Camera")),
              SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    getImageFile(ImageSource.gallery)
                        .whenComplete(() => Navigator.pop(context));
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

  Widget labour(List emplist) {
    print("ss ");
    print(emplist);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[200]),
          color: Colors.white),
      height: 210,
      margin: EdgeInsets.only(left: 25, right: 25, top: 10),
      child: MultiSelectDialogField(
        decoration: BoxDecoration(),
        buttonIcon: Icon(
          Icons.arrow_drop_down_sharp,
          size: 27,
        ),
        buttonText: Text("Labour",
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        items:
            emplist.map((e) => MultiSelectItem(e, e["emp_firstname"])).toList(),
        listType: MultiSelectListType.LIST,
        onConfirm: (values) {
          NewList = values;
          for (int i = 0; i < NewList.length; i++) {
            setState(() {
              nameList.insert(i, NewList[i]["emp_firstname"]);
            });
          }
        },
      ),
    );
  }
}
