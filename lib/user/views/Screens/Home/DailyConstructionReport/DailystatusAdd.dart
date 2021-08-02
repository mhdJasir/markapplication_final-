import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/main.dart';
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
              ElevatedButton.icon(
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
              ElevatedButton.icon(
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

  String project;
  var employ;
  File _image;
  ImagePicker _picker = ImagePicker();
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

  Widget _unemployee(List emplist) {
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

  Color main = Color(0xFFF6F6F6);
  Size get size => MediaQuery.of(context).size;
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
            "Daily Status Add",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: main,
        ),
        body: _con.loading == false
            ? SingleChildScrollView(
                child: Container(
                  color: MyApp.bgColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      buildField(_con.projectlist),
                      _unemployee(_con.emppList),
                      SizedBox(
                        height: 10,
                      ),
                      buildContainer("Job", 60),
                      SizedBox(
                        height: 10,
                      ),
                      buildContainer("Assigned Work Description", 120),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _con.adddasts(
                            project,
                            nameList,
                            descr_contr.text,
                            _image,
                            context,
                          );
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
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Container buildContainer(hintText, double height) {
    return Container(
      width: size.width - 50,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.grey[200])),
      child: TextField(
        autofocus: false,
        controller: descr_contr,
        textAlign: TextAlign.justify,
        maxLines: 9,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            hintText: hintText,
            hintStyle: g615W5,
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }

  Widget buildField(List projct) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[50]),
            color: Colors.white),
        height: 60,
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: FormField(builder: (FormFieldState<String> state) {
          return InputDecorator(
              baseStyle: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey[200])),
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    project == null ? 'Projects' : project,
                    style: TextStyle(
                        color: project == null
                            ? Colors.grey[600]
                            : Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  isDense: true,
                  items: projct.map(
                    (item) {
                      return DropdownMenuItem<String>(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 8),
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
                    setState(() {
                      project = val;
                    });
                  },
                ),
              ));
        }));
  }
}
