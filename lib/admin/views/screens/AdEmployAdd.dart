import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/Repo/getdeprtmntapi.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart' as p;

class AdEmpAdd extends StatefulWidget {
  final tokens;
  AdEmpAdd({this.tokens});

  @override
  _AdEmpAddState createState() => _AdEmpAddState();
}

class _AdEmpAddState extends StateMVC<AdEmpAdd> {
  HomeController _con;

  _AdEmpAddState() : super(HomeController()) {
    _con = controller;
  }
  DateTime _currentjoindate = new DateTime.now();
  final DateFormat formatdate = DateFormat('dd/MM/yyyy');
  var txt = "Joining Date";
  bool a;
  File _image;
  Uri apiUrl =
      Uri.parse('http://markbuilders.in/admin/public/api/admin_add_employees');
  // PickedFile imagefile;
  final TextEditingController efnamecontr = TextEditingController();
  final TextEditingController elnamecontr = TextEditingController();
  final TextEditingController phonnocontr = TextEditingController();
  final TextEditingController passwrdcontr = TextEditingController();
  final TextEditingController empslrycontr = TextEditingController();
  final TextEditingController empidcontr = TextEditingController();
  final TextEditingController empmailcontr = TextEditingController();
  Validations validations = new Validations();

  // final ImagePicker _picker = ImagePicker();
  String deprtmnt, designtn;
  String uploadedimage;
  ImagePicker _picker = ImagePicker();
  Widget _department(List data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[400])),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onTap: () {
            setState(() {});
          },
          isExpanded: true,
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Text(
              'Department',
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
                    item["dep_name"],
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
                deprtmnt = val;
                this.getdesignation(deprtmnt);
              },
            );
          },
          value: deprtmnt,
        ),
      ),
    );
  }

  Widget _designation(List datas) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[400])),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              "Designation",
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
          items: datas.map(
            (item) {
              return new DropdownMenuItem(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: new Text(
                    item["des_name"].toString(),
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
                designtn = val;
              },
            );
          },
          value: designtn,
        ),
      ),
    );
  }

  var deprtmntlist = [];
  var designtionlist = [];
  var imgname;
  Future<Null> _selectendDate(BuildContext context) async {
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
        a = false;
      });
    }
  }

  // void takephoto(ImageSource source) async {
  //   final pickedfile = await _picker.getImage(source: source);
  //
  //   var impp = await _con.uploaimg(pickedfile.path,p.extension(pickedfile.path ));
  //   setState(() {
  //     imagefile = pickedfile;
  //   });
  //   print("AAAAAA"+impp.toString());
  //   imgname= (File(imagefile.path));
  //   print("imaaaaa"+imgname.toString());
  //
  //
  //   Navigator.pop(context);
  //   print("aaaaaaaaaa"+imagefile.toString());
  //
  // }

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

  @override
  void initState() {
    this.getdeprtmnt();
    _con.getemployyiddd(widget.tokens);

    a = true;
    super.initState();
  }

  Future getdeprtmnt() async {
    var rsp = await getDep();
    if (rsp["status"] == "1") {
      setState(() {
        deprtmntlist = rsp['data'];
      });
    }
  }

  Future getdesignation(id) async {
    var rsp = await getDesigntn(id);
    if (rsp["status"] == "1") {
      setState(() {
        designtionlist = rsp['data'];
      });
    }
  }

  var autovalidate;
  submit(endformatted, context) async {
    if (elnamecontr.text.isEmpty) {
      setState(() {
        elnamecontr.text = "";
      });
    }
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true;
    } else {
      form.save();
      // _uploadImage(_image);
      _con.addembloy(
          efnamecontr.text,
          elnamecontr.text,
          passwrdcontr.text,
          endformatted,
          phonnocontr.text,
          empslrycontr.text,
          deprtmnt,
          empmailcontr.text,
          designtn,
          context,
          _image,
          p.extension(_image.path),
          widget.tokens,
          _con.empid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String endformatted = formatdate.format(_currentjoindate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee Add",
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
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  validator: validations.validateFirstName,
                  controller: efnamecontr,
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
                    hintText: "Employee First Name",
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
                child: TextFormField(
                  controller: elnamecontr,
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
                    hintText: "Last Name",
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
                child: TextFormField(
                  validator: validations.validateMobile,
                  controller: phonnocontr,
                  keyboardType: TextInputType.phone,
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
                    hintText: "Phone Number",
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
                child: TextFormField(
                  validator: validations.validatePassword,
                  controller: passwrdcontr,
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
                    hintText: "Password",
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
                child: TextFormField(
                  controller: empmailcontr,
                  keyboardType: TextInputType.emailAddress,
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
                    hintText: "Mail",
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
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: validations.validateSalary,
                  controller: empslrycontr,
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
                    hintText: "Employee Salary",
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
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                          child: _con.empid != null
                              ? Text(
                                  _con.empid,
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 11, horizontal: 8),
                                  child: Container(),
                                )))),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _selectendDate(context),
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
                                a == true
                                    ? "$txt"
                                    : '$endformatted'.split(' ')[0],
                                style: TextStyle(
                                    color: a == true
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
                  child: _department(deprtmntlist)),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 9, left: 9),
                  child: _designation(designtionlist)),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    submit(endformatted, context);
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
