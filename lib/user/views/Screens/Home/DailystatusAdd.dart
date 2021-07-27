import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Daily_Controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DailyStatusAdd extends StatefulWidget {
  final token;
  DailyStatusAdd({this.token});
  @override
  _DailyStatusAddState createState() => _DailyStatusAddState();
}

class _DailyStatusAddState extends StateMVC<DailyStatusAdd> {
  DailyController _con;

  _DailyStatusAddState() : super(DailyController()) {
    _con = controller;
  }

  final TextEditingController descr_contr = TextEditingController();
  File _image;
  var nameList = [];
  var NewList;

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
              FlatButton.icon(
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
              FlatButton.icon(
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

  final ImagePicker _picker = ImagePicker();
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

  // void takephoto(ImageSource source) async {
  //   final pickedfile = await _picker.getImage(source: source);
  //   setState(() {
  //     _imagefile = pickedfile;
  //   });
  //   Navigator.pop(context);
  //   print("sssssssssssss$_imagefile");
  // }
  String project;
  var employ;
  Widget _projectss(List projct) {
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9),
      child: Container(
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
                project == null ? 'Projects' : project,
                style: TextStyle(
                    color:
                        project == null ? Colors.grey[600] : Colors.grey[900],
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.grey[600]),
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
                  value: item["project_name"].toString(),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  project = val;
                  print("PROJECTEDEDDED " + project);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _unemployee(List emplist) {
    print("ss ");
    print(emplist);
    return Padding(
      padding: const EdgeInsets.only(right: 9, left: 9),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.grey[400])),
        child: MultiSelectDialogField(
          decoration: BoxDecoration(),
          buttonIcon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 27,
          ),
          buttonText: Text("Unemployee",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
          items: emplist
              .map((e) => MultiSelectItem(e, e["emp_firstname"]))
              .toList(),
          listType: MultiSelectListType.LIST,
          onConfirm: (values) {
            print("DDDDDDDD " + values.toString());
            NewList = values;
            for (int i = 0; i < NewList.length; i++) {
              setState(() {
                nameList.insert(i, NewList[i]["emp_firstname"]);
              });
            }
            print("################# name list : " + nameList.toString());
          },
        ),
      ),
    );
  }

  String currntdate;
  String currentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    setState(() {
      currntdate = formatter.format(now);
    });
    print("CCCCCCCCCCC$currntdate");
  }

  @override
  void initState() {
    print("AAAAAAAAA");
    currentdate();
    _con.getproject(widget.token);
    _con.getstaff(widget.token);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Daily Status Add",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff496ab1),
        ),
        body: _con.loading == false
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _projectss(_con.projectlist),
                    SizedBox(
                      height: 10,
                    ),
                    _unemployee(_con.emppList),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, left: 9),
                      child: Container(
                        height: 122,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(width: 1, color: Colors.grey[400])),
                        child: TextField(
                          controller: descr_contr,
                          textAlign: TextAlign.justify,
                          maxLines: 9,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              hintText: "Description..",
                              hintStyle: g615W5,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, left: 9),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) =>
                                    imagepickbottomsheet(context)));
                            print("fffffffffffff");
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          _con.adddasts(
                            project,
                            nameList,
                            descr_contr.text,
                            _image,
                            widget.token,
                          );
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdBottomtabs())) ;
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 50,
                          padding: EdgeInsets.all(11),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xff4a67b3)),
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
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
