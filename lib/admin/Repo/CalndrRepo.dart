import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future viewholy() async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');
  final String url = NetworkUtils.adminviewholiday;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var vieyhol = json.decode(res.body);
  return vieyhol;
}

Future viecalnder() async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');
  final String url = NetworkUtils.adminviewcalendar;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var cal = json.decode(res.body);
  return cal;
}

Future addcalnder(evnam, evdte) async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');
  final String url = NetworkUtils.adminaddcalendar;
  final responseFollow = await http.post(Uri.parse(url), body: {
    "event_name": evnam.toString(),
    "event_date": evdte.toString(),
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var adcal = json.decode(responseFollow.body);
  return adcal;
}

Future addholyviewcal(evnam, evdte) async {
  var pref = await SharedPreferences.getInstance();
  var token = pref.getString('tokenid');
  final String url = NetworkUtils.adminaddholiday;
  final responseFollow = await http.post(Uri.parse(url), body: {
    "hname": evnam.toString(),
    "date": evdte.toString(),
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var holyy = json.decode(responseFollow.body);
  return holyy;
}
