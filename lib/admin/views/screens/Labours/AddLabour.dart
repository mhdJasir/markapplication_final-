import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../main.dart';

class AddLabours extends StatefulWidget {
  String token;
  AddLabours(this.token);
  @override
  _AddLaboursState createState() => _AddLaboursState();
}

class _AddLaboursState extends StateMVC<AddLabours> {
  HomeController _con;
  _AddLaboursState() : super(HomeController()) {
    _con = controller;
  }
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Validations validations = Validations();
  ImagePicker _picker = ImagePicker();
  File _image;
  var _joinedDate;
  List jobs;
  var jobId;
  var empId;
  apiCalling() async {
    await _con.labourJobs(widget.token);
    await _con.getemployyiddd(widget.token);
    empId = _con.empid;
    print("employ id data  :" + empId.toString());
  }

  @override
  void initState() {
    apiCalling();
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
          "Add Labours",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: ListView(
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                buildTextFields(validations.validateFirstName, firstname,
                    "Labour First Name", TextInputType.name),
                buildTextFields(null, null, "Last Name", TextInputType.name),
                buildTextFields(validations.validateMobile, phone,
                    "Phone Number", TextInputType.number),
                jobCategories(_con.jobs),
                Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: MyApp.border),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8),
                            child: Text(
                              empId == null ? "empid" : empId,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )))),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => selectedDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: MyApp.border)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _joinedDate == null
                                      ? "Joining Date"
                                      : _joinedDate.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Labor Photo",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Container(
                //   height: 50,
                //   width: MediaQuery.of(context).size.width - 40,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.rectangle,
                //       borderRadius: BorderRadius.circular(15),
                //       border: MyApp.bord),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 15,
                //       ),
                //       Container(
                //         height: 30,
                //         width: 100,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.rectangle, border: MyApp.bord),
                //         child: Center(child: Text("select Photo")),
                //       ),
                //       Flexible(
                //           child: Text(_image.path == null
                //               ? ""
                //               : _image.path.toString())),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState.validate()) {
                          _con.addLabour(
                              widget.token,
                              firstname.text,
                              lastname.text,
                              empId,
                              _joinedDate,
                              phone.text,
                              jobId,
                              context);
                        }
                        null;
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
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget jobCategories(List data) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyApp.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Text(
              'Job',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          iconSize: 30.0,
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.w500,
              fontSize: 15),
          items: data.map(
            (item) {
              return new DropdownMenuItem(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    item["job_title"],
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
                jobId = val;
                print("value  :" + val);
              },
            );
          },
          value: jobId,
        ),
      ),
    );
  }

  Widget buildTextFields(validation, controller, text, keytype) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            child: TextFormField(
              keyboardType: keytype,
              validator: validation,
              controller: controller,
              style: TextStyle(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.border),
                    borderRadius: BorderRadius.circular(15)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.border),
                    borderRadius: BorderRadius.circular(15)),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.border),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.border),
                    borderRadius: BorderRadius.circular(15)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                hintText: text,
                errorStyle: TextStyle(height: 0),
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  pickImage(source) async {
    var image = await _picker.pickImage(source: source);
    File file = File(image.path);
    File Compressed = await compressFile(file);
    setState(() {
      _image = Compressed;
      Navigator.pop(context);
    });
    print(file.lengthSync());

    print("image size  :" + file.lengthSync().toString());
  }

  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50,
    );

    print("result   : " + result.lengthSync().toString());

    return result;
  }

  Future<Null> selectedDate(BuildContext context) async {
    final DateFormat formatdate = DateFormat('dd/MM/yyyy');
    DateTime date;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      fieldHintText: "dd/mm/yyyy",
      lastDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() {
        date = picked;
        _joinedDate = formatdate.format(date);
      });
    }
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
                    pickImage(ImageSource.camera);
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
                    pickImage(ImageSource.gallery);
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
}
