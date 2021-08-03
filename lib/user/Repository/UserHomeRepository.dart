import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';

Future usrviewholydy(token) async {
  final String url = NetworkUtils.staffviewholiday;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var vieyhol = json.decode(res.body);
  return vieyhol;
}

Future<Map> viewtask(token) async {
  final String url = NetworkUtils.staffviewtask;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var task = json.decode(res.body);
    return task;
  }
  return Map();
}

Future<Map> viewleave(token) async {
  final String url = NetworkUtils.staffviewleave;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var viewlev = json.decode(res.body);
    return viewlev;
  }
  return Map();
}

Future<Map> stffaddattndece(String token, String date, int attndnce) async {
  final String url = NetworkUtils.staffaddatttendence +
      "?date=$date&attendance=${attndnce.toString()}";
  final res = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer " + token.toString(),
  });
  if (res.statusCode == 200) {
    var addattndnce = json.decode(res.body);
    return addattndnce;
  }
  return Map();
}

Future<Map> staffdailystatus() async {
  final String url = NetworkUtils.staffviewdailystatus;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + NetworkUtils.token,
  });
  if (res.statusCode == 200) {
    var dailys = json.decode(res.body);
    return dailys;
  }
  return Map();
}

Future<Map> stffaddleave(String leavtype, String from, String to, String reson,
    int totaldys, String token) async {
  final String url = NetworkUtils.staffaddleave;
  final res = await http.post(Uri.parse(url), body: {
    "l_type": leavtype.toString(),
    "from": from.toString(),
    "to": to.toString(),
    "reason": reson.toString(),
    "total_days": totaldys.toString(),
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });

  if (res?.statusCode == 200) {
    var addstaff = json.decode(res.body);
    return addstaff;
  }
  return Map();
}
