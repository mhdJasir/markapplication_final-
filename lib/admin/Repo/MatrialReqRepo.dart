import 'dart:convert';
import 'dart:io';

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;

Future dropviewproj(token) async {
  final String url = NetworkUtils.getproje;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var proj = json.decode(res.body);
  return proj;
}

Future dropviewemployees(token) async {
  final String url = NetworkUtils.getemployees;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var emp = json.decode(res.body);
  return emp;
}

Future dropvendor(token) async {
  final String url = NetworkUtils.getvendor;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var vndr = json.decode(res.body);
  return vndr;
}

Future<Map> dropitemss(token) async {
  final String url = NetworkUtils.getitems;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res.statusCode == 200) {
    var itms = json.decode(res.body);
    return itms;
  }
  return Map();
}

Future<Map> addmatreq(String pject, String hading, String des, String stf,
    String vndor, List itemarray, String orderValue, String token) async {
  final String url = NetworkUtils.addmatreq;
  final res = await http.post(
    Uri.parse(url),
    body: {
      "project": pject,
      "heading": hading,
      "description": des,
      "emp": stf,
      "vendor": vndor,
      "item_array": jsonEncode(itemarray),
      "order_value": orderValue
    },
    headers: {
      "Authorization": "Bearer " + token.toString(),
    },
  );
  if (res.statusCode == 200) {
    var matreq = json.decode(res.body);
    return matreq;
  }
  return Map();
}

Future addmoneytransfer(empid, pytype, amount, renrk, token) async {
  final String url = NetworkUtils.addmoneytrnsfr;
  final responseFollow = await http.post(
    Uri.parse(url),
    body: {
      "emp_id": empid.toString(),
      "type": pytype.toString(),
      "amount": amount.toString(),
      "remark": renrk.toString(),
    },
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
    },
  );
  var addmonytrnsfr = json.decode(responseFollow.body);
  return addmonytrnsfr;
}

Future updatematreq(vendor, status, id, token) async {
  final String url = NetworkUtils.adupdatematreqq;
  final responseFollow = await http.post(
    Uri.parse(url),
    body: {
      "vendor": vendor.toString(),
      "status": status.toString(),
      "id": id.toString(),
    },
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
    },
  );
  var addmonytrnsfr = json.decode(responseFollow.body);
  return addmonytrnsfr;
}

Future updatepurchseorder(purid, mode, token) async {
  final String url = NetworkUtils.adpurchseupdtion;
  final responseFollow = await http.post(
    Uri.parse(url),
    body: {
      "purchase_id": purid.toString(),
      "mode": mode.toString(),
    },
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
    },
  );
  var addmonytrnsfr = json.decode(responseFollow.body);
  return addmonytrnsfr;
}
