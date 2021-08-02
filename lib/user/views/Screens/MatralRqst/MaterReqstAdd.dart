import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmarkgrp/admin/views/widgets/WidgetStyle.dart';
import 'package:hrmarkgrp/user/controller/Mat_Req_Controllr.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddMaterialRequirements extends StatefulWidget {
  final token;
  AddMaterialRequirements({this.token});
  @override
  _AddMaterialRequirementsState createState() =>
      _AddMaterialRequirementsState();
}

class _AddMaterialRequirementsState extends StateMVC<AddMaterialRequirements> {
  StaffMaterialReq _con;
  _AddMaterialRequirementsState() : super(StaffMaterialReq()) {
    _con = controller;
  }
  var itemQtyList = List.generate(4, (index) => TextEditingController());
  var itemPrice = List.generate(4, (index) => TextEditingController());

  TextEditingController headingcontroller = TextEditingController();
  TextEditingController descrcontrlr = TextEditingController();
  TextEditingController orderValueCtrl = TextEditingController();

  var items = List<String>.generate(4, (index) => null);
  var itemAmounts = List<int>.generate(4, (index) => 0);
  String project;

  _currentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  void initState() {
    _con.getproject(widget.token);
    _con.getitms(widget.token);
    setState(() {});
    super.initState();
  }

  Color main = Color(0xFFF6F6F6);
  Color border = Color(0xFFE9E9E9);
  Size get size => MediaQuery.of(context).size;
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
          "Add New",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: main,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _projectss(_con.projectlist),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: border),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: headingcontroller,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      hintText: "Heading",
                      hintStyle: g615W5,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: border),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    child: Text(
                      _currentdate(),
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
            _itemRow("Item 1", 0),
            _itemRow("Item 2", 1),
            _itemRow("Item 3", 2),
            _itemRow("Item 4", 3),
            Row(
              children: [
                Expanded(flex: 1, child: Column()),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        margin: EdgeInsets.only(left: 5, right: 20, top: 20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: border),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: orderValueCtrl,
                          enabled: false,
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 8),
                              hintText: "Order value",
                              hintStyle: g615W5,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              child: Container(
                height: 122,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: border)),
                child: TextField(
                  controller: descrcontrlr,
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
              padding: const EdgeInsets.only(right: 15, left: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (project != null && headingcontroller.text.isNotEmpty) {
                      var itemArray = [];
                      if (items[0] != null) {
                        itemArray.add({
                          "item_id": items[0],
                          "qty": itemQtyList[0].text.isNotEmpty
                              ? itemQtyList[0].text
                              : "1",
                          "basic_amount": itemPrice[0].text.isNotEmpty
                              ? itemPrice[0].text
                              : "1"
                        });
                      }
                      if (items[1] != null) {
                        itemArray.add({
                          "item_id": items[1],
                          "qty": itemQtyList[1].text.isNotEmpty
                              ? itemQtyList[1].text
                              : "1",
                          "basic_amount": itemPrice[1].text.isNotEmpty
                              ? itemPrice[1].text
                              : "1"
                        });
                      }
                      if (items[2] != null) {
                        itemArray.add({
                          "item_id": items[2],
                          "qty": itemQtyList[2].text.isNotEmpty
                              ? itemQtyList[2].text
                              : "1",
                          "basic_amount": itemPrice[2].text.isNotEmpty
                              ? itemPrice[2].text
                              : "1"
                        });
                      }
                      if (items[3] != null) {
                        itemArray.add({
                          "item_id": items[3],
                          "qty": itemQtyList[3].text.isNotEmpty
                              ? itemQtyList[3].text
                              : "1",
                          "basic_amount": itemPrice[3].text.isNotEmpty
                              ? itemPrice[3].text
                              : "1"
                        });
                      }
                      if (itemArray.length != 0) {
                        _con.stffaddmatreq(
                            project,
                            headingcontroller.text,
                            descrcontrlr.text,
                            itemArray,
                            orderValueCtrl.text,
                            widget.token,
                            context);
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff6DC066),
                      borderRadius: BorderRadius.circular(22),
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

  Widget _projectss(List projct) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: border),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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

  calcOrderValue() {
    orderValueCtrl.text =
        "${int.parse(itemPrice[0].text.isEmpty ? "0" : itemPrice[0].text) + int.parse(itemPrice[1].text.isEmpty ? "0" : itemPrice[1].text) + int.parse(itemPrice[2].text.isEmpty ? "0" : itemPrice[2].text) + int.parse(itemPrice[3].text.isEmpty ? "0" : itemPrice[3].text)}";
  }

  Widget _itemRow(String item, int index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 42,
                      //width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: border),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Text(
                              '$item',
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
                          items: _con.itemList.map(
                            (itmm) {
                              return DropdownMenuItem<String>(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 8),
                                  child: new Text(
                                    itmm["product_name"].toString(),
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                                value: "${itmm["id"]}",
                              );
                            },
                          ).toList(),
                          onChanged: (String val) {
                            setState(
                              () {
                                items[index] = val;
                                print(items[index]);
                                itemAmounts[index] = _con.itemList
                                    .where((e) => "${e["id"]}" == val)
                                    .toList()[0]["basic_amount"];
                                if (itemQtyList[index].text.isNotEmpty) {
                                  var calcPrice = int.parse(
                                          "${itemAmounts[index]}") *
                                      int.parse("${itemQtyList[index].text}");
                                  itemPrice[index].text = "$calcPrice";
                                  calcOrderValue();
                                }
                              },
                            );
                          },
                          value: items[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 42,
                      //width: MediaQuery.of(context).size.width * 0.328,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: border),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(left: 5),
                      child: TextField(
                        controller: itemQtyList[index],
                        onChanged: (v) {
                          if (itemAmounts[index] != 0) {
                            setState(() {
                              if (v.isNotEmpty) {
                                itemPrice[index].text =
                                    "${itemAmounts[index] * int.parse(v)}";
                              } else {
                                itemPrice[index].text = "";
                              }
                              calcOrderValue();
                            });
                          }
                        },
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8),
                            hintText: "Qty",
                            hintStyle: g615W5,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 42,
                      //width: MediaQuery.of(context).size.width * 0.328,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: border),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: itemPrice[index],
                        enabled: false,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8),
                            hintText: "Basic price",
                            hintStyle: g615W5,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
