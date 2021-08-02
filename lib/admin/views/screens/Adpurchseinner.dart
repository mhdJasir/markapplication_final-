import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/controller/MatrialReqController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Adpurchinner extends StatefulWidget {
  final purchase, token;
  Adpurchinner(this.purchase, this.token);
  @override
  _AdpurchinnerState createState() => _AdpurchinnerState();
}

class _AdpurchinnerState extends StateMVC<Adpurchinner> {
  MaterialControllr _con;
  _AdpurchinnerState() : super(MaterialControllr()) {
    _con = controller;
  }
  String pymntmode;
  Widget _projectss() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyApp.border),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          child: Text(
            widget.purchase["project_name"].toString(),
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  Widget _paymentstatus() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: MyApp.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              pymntmode == null ? 'Payment Mode' : pymntmode,
              style: TextStyle(
                  color:
                      pymntmode == null ? Colors.grey[600] : Colors.grey[900],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.grey[600]),
          items: [
            'Cash',
            'Bank',
            'Cheque',
            'Rtgs/Neft',
          ].map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
              () {
                pymntmode = val;
              },
            );
          },
        ),
      ),
    );
  }

  File _image;

  ImagePicker _picker = ImagePicker();
  pickImage(source) async {
    var image = await _picker.pickImage(source: source);
    File file = File(image.path);
    File compressed = await compressFile(file);
    setState(() {
      _image = compressed;
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

  @override
  void initState() {
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
          widget.purchase["project_name"].toString(),
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyApp.border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.purchase["purchase_date"].toString(),
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyApp.border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.purchase["heading"].toString(),
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
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: _projectss(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: _paymentstatus(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyApp.border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      widget.purchase["description"].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            widget.purchase["items"].length == 0
                ? Container(height: 0)
                : Container(
                    height: 160,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.purchase["items"] != null
                            ? widget.purchase["items"].length
                            : 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 42,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: MyApp.border),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.purchase["items"][index]
                                                    ["product_name"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          )),
                                    ),
                                    Container(
                                      width: 79,
                                      height: 42,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          // validator: validations.validateFirstName,
                                          // controller: clintfname_contr,
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: MyApp.border),
                                                    borderRadius: BorderRadius
                                                        .circular(15)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 4),
                                            hintText: "Unit Cost",
                                            hintStyle: g615W5,
                                            border: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 42,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: MyApp.border),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.purchase["items"][index]
                                                    ["qty"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          )),
                                    ),
                                    Container(
                                      width: 64,
                                      height: 42,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          // validator: validations.validateFirstName,
                                          // controller: clintfname_contr,
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: MyApp.border),
                                                    borderRadius: BorderRadius
                                                        .circular(15)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MyApp.border),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 4),
                                            hintText: "Amount",
                                            hintStyle: g615W5,
                                            border: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 79,
                height: 42,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // validator: validations.validateFirstName,
                    // controller: clintfname_contr,
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
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      hintText: "Total",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 79,
                height: 42,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // validator: validations.validateFirstName,
                    // controller: clintfname_contr,
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
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      hintText: "Tax",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 79,
                height: 42,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // validator: validations.validateFirstName,
                    // controller: clintfname_contr,
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
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      hintText: "Discount",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                width: 100,
                height: 42,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // validator: validations.validateFirstName,
                    // controller: clintfname_contr,
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
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      hintText: "Grand Total",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
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
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (pymntmode == null) {
                  Fluttertoast.showToast(
                    msg: "Select PaymentMode",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 35,
                    backgroundColor: Colors.black,
                    fontSize: 16.0,
                  );
                } else {
                  _con.updtepurchseorder(
                      widget.purchase["purchase_id"].toString(),
                      pymntmode,
                      widget.token,
                      context);
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
      ),
    );
  }
}
