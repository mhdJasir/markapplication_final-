import 'dart:convert';
import 'dart:io';

import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

Future<Map> dropviewproj(token) async {
  final String url = NetworkUtils.getproje;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var proj = json.decode(res.body);
    return proj;
  }
  return Map();
}

Future<Map> dropviewemployees(token) async {
  final String url = NetworkUtils.getunemloyees;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var emp = json.decode(res.body);
    return emp;
  }
  return Map();
}

Future adddailysts(
  String projc,
  List employees,
  String disc,
  File imaag,
) async {
  Uri apiUrl = Uri.parse(NetworkUtils.staffadddailystats);
  final mimeTypeData =
      lookupMimeType(imaag.path, headerBytes: [0xFF, 0xD8]).split('/');
  Map<String, String> headers = {
    "Authorization": "Bearer " + NetworkUtils.token
  };
  // Intilize the multipart request

  var adddailysts = http.MultipartRequest('POST', apiUrl);
  // Attach the file in the request
  final imag = await http.MultipartFile.fromPath('file', imaag.path,
      filename: basename(imaag.path),
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  adddailysts.files.add(imag);
  adddailysts.fields['project'] = projc;
  for (var i = 0; i < employees.length; i++) {
    adddailysts.fields["unemployee[$i]"] = employees[i].toString();
  }
  adddailysts.fields['description'] = disc;

  try {
    adddailysts.headers.addAll(headers);
    final streamedResponse = await adddailysts.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future staffdailyexpnceview(token) async {
  final String url = NetworkUtils.stffviewdailyexpance;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var dilyexpncevie = json.decode(res.body);
  return dilyexpncevie;
}

Future updatestaffdailyexpnce(
    expid, status, paidamount, total, File img, token) async {
  Uri apiUrl = Uri.parse(NetworkUtils.staffupdatedailyexpance);

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString()
  };
  final mimeTypeData =
      lookupMimeType(img.path, headerBytes: [0xFF, 0xD8]).split('/');

  // Intilize the multipart request

  final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
  // Attach the file in the request
  final file = await http.MultipartFile.fromPath('image', img.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  imageUploadRequest.files.add(file);
  imageUploadRequest.fields['expanse_id'] = expid.toString();
  imageUploadRequest.fields['status'] = status.toString();
  imageUploadRequest.fields['paid'] = paidamount.toString();
  imageUploadRequest.fields['total'] = total.toString();
  try {
    imageUploadRequest.headers.addAll(headers);
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    return responseData;
  } catch (e) {
    return null;
  }
}

Future staffdailytaskview(token) async {
  final String url = NetworkUtils.staffdailytaskview;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var daly = json.decode(res.body);
  return daly;
}

Future adddailytask(pject, remark) async {
  final String url = NetworkUtils.staffadddailytask;
  final res = await http.post(Uri.parse(url), body: {
    "project": pject.toString(),
    "remark": remark.toString()
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + NetworkUtils.token,
  });
  var dalytask = json.decode(res.body);
  return dalytask;
}
