import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrmarkgrp/admin/controller/MatrialReqController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
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
  ImagePicker _picker = ImagePicker();

  // static const label = "";
  // static const dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5','Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10'];
  // TextEditingController myController1 = TextEditingController();
  // TextEditingController myController2= TextEditingController();
  // TextEditingController myController3 = TextEditingController();

  // PickedFile _imagefile;
  // final ImagePicker _picker = ImagePicker();
  // void takephoto(ImageSource source) async {
  //   final pickedfile = await _picker.getImage(source: source);
  //   setState(() {
  //     _imagefile = pickedfile;
  //   });
  //   Navigator.pop(context);
  //   print("aaaaaaaaaa$_imagefile");
  // }
  //
  // Widget imagepickbottomsheet(context) {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery
  //         .of(context)
  //         .size
  //         .width,
  //     margin: EdgeInsets.symmetric(
  //         vertical: 20, horizontal: 20
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Text("Choose Profile Photo",
  //           style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
  //         SizedBox(height: 20,),
  //         Row(mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             FlatButton.icon(onPressed: () {
  //               takephoto(ImageSource.camera);
  //             },
  //                 icon: Icon(Icons.camera_alt,size: 30,),
  //                 label: Text("Camera")),
  //             SizedBox(width: 20,),
  //             FlatButton.icon(onPressed: () {
  //               takephoto(ImageSource.gallery);
  //             },
  //                 icon: Icon(Icons.image,size: 30,),
  //                 label: Text("Gallery"))
  //           ],)
  //       ],
  //     ),
  //
  //   );
  // }

  String pymntmode;
  Widget _projectss() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[400]),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
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
          border: Border.all(width: 1, color: Colors.grey[400])),
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.purchase["project_name"].toString(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff496ab1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
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
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
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
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: _projectss(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9, left: 9),
              child: _paymentstatus(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 9,
                left: 9,
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[400]),
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
                    height: 270,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.purchase["items"] != null
                            ? widget.purchase["items"].length
                            : 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 9, left: 9, top: 10),
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
                                            width: 1, color: Colors.grey[400]),
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
                                                    color: Colors.grey[400]),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.grey[400]),
                                                    borderRadius: BorderRadius
                                                        .circular(15)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[400]),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[400]),
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
                                            width: 1, color: Colors.grey[400]),
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
                                                    color: Colors.grey[400]),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.grey[400]),
                                                    borderRadius: BorderRadius
                                                        .circular(15)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[400]),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[400]),
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
                margin: EdgeInsets.only(right: 9),
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
                margin: EdgeInsets.only(right: 9),
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
                margin: EdgeInsets.only(right: 9),
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
                margin: EdgeInsets.only(right: 9),
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
              height: 50,
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
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: GestureDetector(
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
              _con.updtepurchseorder(widget.purchase["purchase_id"].toString(),
                  pymntmode, widget.token, context);
            }

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
    );
  }
}
