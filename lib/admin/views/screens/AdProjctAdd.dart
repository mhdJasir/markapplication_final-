import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AdProjAdd extends StatefulWidget {
  final token;
  AdProjAdd({this.token});
  @override
  _AdProjAddState createState() => _AdProjAddState();
}

class _AdProjAddState extends StateMVC<AdProjAdd> {
  HomeController _con;

  _AdProjAddState() : super(HomeController()) {
    _con = controller;
  }
  DateTime _currentjoindate = new DateTime.now();
  DateTime _currentenddate = new DateTime.now();
  final DateFormat formatdate = DateFormat('dd/MM/yyyy');
  String strtdte = "Start Date";
  String endtxtdte = "End Date";
  bool strt, endte;
  String clientdd;
  Validations validations = new Validations();
  final TextEditingController projnamContr = TextEditingController();
  final TextEditingController totalprojCocnt = TextEditingController();
  final TextEditingController descrContr = TextEditingController();
  Future<Null> _selectstrtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _currentjoindate,
      firstDate: DateTime(1980),
      fieldHintText: "dd/mm/yyyy",
      lastDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() {
        _currentjoindate = picked;
        strt = false;
      });
    }
  }

  Future<Null> _selectendtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _currentenddate,
      firstDate: DateTime(1980),
      fieldHintText: "dd/mm/yyyy",
      lastDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() {
        _currentenddate = picked;
        endte = false;
      });
    }
  }

  var b;
  Widget _client(List clientdata) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[400])),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              'Client',
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
          items: clientdata.map(
            (item) {
              return DropdownMenuItem<String>(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: new Text(
                    item["firstname"].toString(),
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
                clientdd = val;
              },
            );
          },
          value: clientdd,
        ),
      ),
    );
  }

  String filename;
  File file;
  Future<void> _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      setState(() {
        file = File(result.files.first.path);
        filename = file.path.split('/').last;
      });
    }
  }

  @override
  void initState() {
    _con.viewclint(widget.token);
    super.initState();
    strt = true;
    endte = true;
  }

  var autovalidate;
  submit(context) async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true;
    } else {
      form.save();
      _con.addproject(
          projnamContr.text,
          clientdd,
          _currentjoindate,
          _currentenddate,
          totalprojCocnt.text,
          descrContr.text,
          context,
          file,
          p.extension(file.path),
          widget.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String strtdate = formatdate.format(_currentjoindate);
    final String enddate = formatdate.format(_currentenddate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project Add",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: SingleChildScrollView(
        child: Form(
          key: _con.loginFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: TextFormField(
                  validator: validations.validateName,
                  controller: projnamContr,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    hintText: "Project Name",
                    hintStyle: g615W5,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: _client(_con.viewclient),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _selectstrtDate(
                      context,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[400])),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                strt == true ? "$strtdte" : '$strtdate',
                                style: TextStyle(
                                    color: strt == true
                                        ? Colors.grey[600]
                                        : Colors.grey[900],
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _selectendtDate(
                      context,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[400])),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                endte == true
                                    ? "$endtxtdte"
                                    : '$enddate'.split(' ')[0],
                                style: TextStyle(
                                    color: endte == true
                                        ? Colors.grey[600]
                                        : Colors.grey[900],
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: validations.validateProjcost,
                  controller: totalprojCocnt,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(15)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    hintText: "Total Project Cost",
                    hintStyle: g615W5,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
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
                      border: Border.all(width: 1, color: Colors.grey[400])),
                  child: TextField(
                    controller: descrContr,
                    textAlign: TextAlign.justify,
                    maxLines: 9,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                padding: const EdgeInsets.only(left: 12, right: 9),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _openFileExplorer();
                      },
                      child: Container(
                        height: 33,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Color(0xff4a67b3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.upload_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Upload",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Text(
                          filename == null
                              ? "No archive found"
                              : filename.toString(),
                          textAlign: TextAlign.justify,
                          style: g615W5),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    submit(context);
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
        ),
      ),
    );
  }
}
