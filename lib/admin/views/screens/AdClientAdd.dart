import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hrmarkgrp/Widgets/Styles/validate_Fields.dart';
import 'package:hrmarkgrp/admin/controller/HomeController.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart' as p;

import '../../../main.dart';

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
          "Add Client",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: MyApp.appBar,
      ),
      backgroundColor: Color(0xfff5f6f8),
      body: SingleChildScrollView(
        child: Form(
          key: _con.loginFormKey,
          child: Column(
            children: <Widget>[
              buildTextFields(validations.validateFirstName, clintfnamecontr,
                  "First Name", TextInputType.name),
              buildTextFields(
                  null, cllastnamecontr, "Last Name", TextInputType.name),
              buildTextFields(validations.validateMail, emailcontr, "Email",
                  TextInputType.emailAddress),
              Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 15),
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: MyApp.border),
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
              buildTextFields(validations.validatecombnay, combnycontr,
                  "Company", TextInputType.text),
              buildTextFields(validations.validateMobile, phon1contr, "Phone 1",
                  TextInputType.number),
              buildTextFields(
                  null, phon2contr, "Phone 2", TextInputType.number),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      submit(context);
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
      ),
    );
  }

  Widget buildTextFields(validator, controller, text, keytype) {
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
              validator: validator,
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
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                hintText: text,
                hintStyle: g615W5,
                errorStyle: TextStyle(height: 0),
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
