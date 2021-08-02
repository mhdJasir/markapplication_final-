import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart' as p;

class AdClientAdd extends StatefulWidget {
  final tok;
  AdClientAdd({this.tok});
  @override
  _AdClientAddState createState() => _AdClientAddState();
}

class _AdClientAddState extends StateMVC<AdClientAdd> {
  HomeController _con;

  _AdClientAddState() : super(HomeController()) {
    _con = controller;
  }

  final TextEditingController clintfnamecontr = TextEditingController();
  final TextEditingController cllastnamecontr = TextEditingController();
  final TextEditingController emailcontr = TextEditingController();
  final TextEditingController clidcontr = TextEditingController();
  final TextEditingController phon1contr = TextEditingController();
  final TextEditingController phon2contr = TextEditingController();
  final TextEditingController combnycontr = TextEditingController();

  File _image;
  ImagePicker _picker = ImagePicker();
  Future getCameraImage() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
      Navigator.pop(context);
    });
    print("mmmmmmmmmmmmm" + _image.toString());
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      Navigator.pop(context);
    });
    print("IMAAAAGGGGGGE" + _image.toString());
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

  Validations validations = new Validations();
  var autovalidate;
  submit(context) async {
    print("aaa");
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autovalidate = true;
      print("faaill");
    } else {
      form.save();
      // _uploadImage(_image);
      _con.addclient(
          clintfnamecontr.text,
          cllastnamecontr.text,
          emailcontr.text,
          combnycontr.text,
          phon1contr.text,
          phon2contr.text,
          context,
          _image,
          p.extension(_image.path),
          widget.tok,
          _con.clientid);
      print("successs");
    }
  }

  @override
  void initState() {
    _con.getclientid(widget.tok);
    print(_con.clientid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Client Add",
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
                  controller: clintfnamecontr,
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
                    hintText: "First Name",
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
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  controller: cllastnamecontr,
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
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: validations.validateMail,
                  controller: emailcontr,
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
                    hintText: "Email",
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
                  padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        child: _con.clientid != null
                            ? Text(
                                _con.clientid,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    right: 9, left: 9, top: 10),
                                child: Container(),
                              ),
                      ))),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: validations.validatecombnay,
                  controller: combnycontr,
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
                    hintText: "Company",
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
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: validations.validateMobile,
                  controller: phon1contr,
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
                    hintText: "Phone 1",
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
                padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phon2contr,
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
                    hintText: "Phone 2",
                    hintStyle: g615W5,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
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
