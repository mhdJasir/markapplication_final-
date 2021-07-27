import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';

Future dropitemss(token) async {
  final String url = NetworkUtils.getitems;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var itms = json.decode(res.body);
  return itms;
}

Future dropviewproj(token) async {
  final String url = NetworkUtils.getproje;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var proj = json.decode(res.body);
  return proj;
}

Future<Map> addstffmatreq(String pject, String hading, String des,
    List itmarray, String orderValue, String token) async {
  try {
    final String url = NetworkUtils.staffAddMatreq;
    var body = {
      "project": pject,
      "heading": hading,
      "description": des,
      "item_array": jsonEncode(itmarray),
      "order_value": orderValue,
    };
    final response = await http.post(Uri.parse(url), body: body, headers: {
      "Authorization": "Bearer " + token.toString(),
    });
    if (response.statusCode == 200) {
      var mat = json.decode(response.body);
      return mat;
    }
    return Map();
  } catch (e) {
    return Map();
  }
}

Future viewstffmatreq(token) async {
  final String url = NetworkUtils.stffviewmatreq;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viwmat = json.decode(res.body);
  return viwmat;
}
