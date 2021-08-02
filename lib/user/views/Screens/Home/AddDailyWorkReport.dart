import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddWorkReport extends StatefulWidget {
  final token;
  AddWorkReport({this.token});
  @override
  _AddWorkReport createState() => _AddWorkReport();
}

class _AddWorkReport extends StateMVC<AddWorkReport> {
  DailyController _con;

  _AddWorkReport() : super(DailyController()) {
    _con = controller;
  }

  String project;
  TextEditingController remarkcontr = TextEditingController();
  _currentdate() {
    var now = new DateTime.now();
    print(now);
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;
  }

  File _image;
  ImagePicker _imagePicker = ImagePicker();
  Color border = Color(0xFFE9E9E9);
  Widget _projectss(List projct) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: border),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              'Projects',
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
              fontSize: 15,
              fontWeight: FontWeight.w500),
          items: projct.map(
            (item) {
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    item["project_name"].toString(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: item["id"].toString(),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                project = val;
              },
            );
          },
          value: project,
        ),
      ),
    );
  }

  @override
  void initState() {
    _con.getproject(widget.token);
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
          "Add Report",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
            //   child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 42,
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 1, color: Colors.grey[400]),
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
            //         child: Text(
            //           _currentdate(),
            //           style: TextStyle(
            //               fontSize: 15,
            //               color: Colors.grey[900],
            //               fontWeight: FontWeight.w500),
            //         ),
            //       )),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: _projectss(_con.projectlist),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: border),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: remarkcontr,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      hintText: " Work Report",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (builder) => imagePickerPopUp(context)),
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null
                          ? NetworkImage('https://git.unilim.fr/assets/'
                              'no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                          : FileImage(_image),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _con.adddailytask(project, remarkcontr.text, context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 50,
                    width: size.width * 0.6,
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

  Widget imagePickerPopUp(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Photo",
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

  getImageFile(ImageSource source) async {
    var image = await _imagePicker.pickImage(source: source);

    // var result = await FlutterImageCompress.compressAndGetFile(
    //   image.path,
    //   image.path,
    //   minWidth: 2300,
    //   minHeight: 1500,
    //   quality: 94,
    //   rotate: 90,
    // );
    setState(() {
      _image = File(image.path);
    });
  }
}
