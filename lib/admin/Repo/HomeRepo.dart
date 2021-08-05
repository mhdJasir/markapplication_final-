import 'dart:convert';
import 'dart:io';
import 'package:hrmarkgrp/Utils/NetworkUtils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

Future adtask(token) async {
  final String url = NetworkUtils.adtask;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var task = json.decode(res.body);
  return task;
}

Future<Map> purchordr(token) async {
  final String url = NetworkUtils.adminpurchaseord;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var pur = json.decode(res.body);
    return pur;
  }
  return Map();
}

Future<Map> dailstss() async {
  final String url = NetworkUtils.dailysta;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + NetworkUtils.token,
  });
  if (res?.statusCode == 200) {
    var task = json.decode(res.body);
    return task;
  }
  return Map();
}

// Future uploadFile(filname,ext) async {
//   var request = http.MultipartRequest('POST', Uri.parse(NetworkUtils.addemployeee));
//   request.files.add(
//     http.MultipartFile(
//         'image',
//         File(filname).readAsBytes().asStream(),
//         File(filname).lengthSync(),
//         filename: filname.split("/").last,contentType: MediaType("image", ext.toString().substring(1))
//     ),
//   );
//   http.Response response = await http.Response.fromStream(await request.send());
//   print("ppppppppp status code :"+response.statusCode.toString());
//   print("ppppppppp  reason :"+response.reasonPhrase.toString());
//   print("profile : "+json.decode(response.body).toString());
//   print("change pic header : " +(response.headers).toString());
//   return json.decode(response.body);
// }
Future admattendance(token) async {
  final String url = NetworkUtils.adviewattndce;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var attnce = json.decode(res.body);
  return attnce;
}

Future clientget(token) async {
  final String url = NetworkUtils.clientid;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var clientid = json.decode(res.body);
  return clientid;
}

Future employid(token) async {
  final String url = NetworkUtils.getemployeeid;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var empid = json.decode(res.body);
  return empid;
}

Future<Map> updteleavstts(String token, String status, String id) async {
  final String url = NetworkUtils.adminupdteleavsts;
  final res = await http.post(Uri.parse(url), body: {
    "status": status,
    "id": id
  }, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  if (res?.statusCode == 200) {
    var leavststs = json.decode(res.body);
    return Map.castFrom(leavststs);
  }
  return Map();
}

Future vimploy(token) async {
  final String url = NetworkUtils.viewemplyees;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viewwmp = json.decode(res.body);
  return viewwmp;
}

Future getttinvo(token) async {
  final String url = NetworkUtils.getinvo;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var invoice = json.decode(res.body);
  return invoice;
}

Future labour(token) async {
  var url = NetworkUtils.labours;
  var response = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  print("status code : " + response.statusCode.toString());
  var data = json.decode(response.body);
  return data;
}

Future jobs(token) async {
  var url = NetworkUtils.labourJobs;
  var response = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  print("status code  :" + response.statusCode.toString());
  var data = json.decode(response.body);
  return data;
}

Future getmaterialr(token) async {
  final String url = NetworkUtils.admingetmatrilrqs;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var getmate = json.decode(res.body);
  return getmate;
}

Future viewpr(token) async {
  final String url = NetworkUtils.viewproject;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viewpro = json.decode(res.body);
  return viewpro;
}

Future viewclin(token) async {
  final String url = NetworkUtils.viewclient;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viecl = json.decode(res.body);
  return viecl;
}

Future viewleave(token) async {
  final String url = NetworkUtils.viewleave;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var vileav = json.decode(res.body);
  return vileav;
}

Future addep(fname, lnam, passw, joidte, phon, slry, dep, mail, des, File img,
    token, empid) async {
  Uri apiUrl = Uri.parse(NetworkUtils.addemployeee);

  final mimeTypeData =
      lookupMimeType(img.path, headerBytes: [0xFF, 0xD8]).split('/');
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString()
  };
  // Intilize the multipart request

  var imageUploadRequest = http.MultipartRequest('POST', apiUrl);
  // Attach the file in the request
  final file = await http.MultipartFile.fromPath('image', img.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  imageUploadRequest.files.add(file);
  imageUploadRequest.fields['fname'] = fname.toString();
  imageUploadRequest.fields['lname'] = lnam.toString();
  imageUploadRequest.fields['password'] = passw.toString();
  imageUploadRequest.fields['empid'] = empid.toString();
  imageUploadRequest.fields['joindate'] = joidte.toString();
  imageUploadRequest.fields['phone'] = phon.toString();
  imageUploadRequest.fields['salary'] = slry.toString();
  imageUploadRequest.fields['dep'] = dep.toString();
  imageUploadRequest.fields['mail'] = mail.toString();
  imageUploadRequest.fields['des'] = des.toString();
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

Future clientadd(
    fname, lnam, email, combny, phone1, phon2, File img, token, clinid) async {
  Uri apiUrl = Uri.parse(NetworkUtils.adminaddclients);
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
  imageUploadRequest.fields['fname'] = fname.toString();
  imageUploadRequest.fields['lname'] = lnam.toString();
  imageUploadRequest.fields['mail'] = email.toString();
  imageUploadRequest.fields['id'] = clinid.toString();
  imageUploadRequest.fields['company'] = combny.toString();
  imageUploadRequest.fields['phone_1'] = phone1.toString();
  imageUploadRequest.fields['phone_2'] = phon2.toString();

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

Future projectadd(pname, client, strtdte, enddate, totprocst, descrptn,
    File upfile, extn, token) async {
  Uri apiUrl = Uri.parse(NetworkUtils.adminaddprojects);
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString()
  };
  final mimeTypeData =
      lookupMimeType(upfile.path, headerBytes: [0xFF, 0xD8]).split('/');
  // Intilize the multipart request
  final addproj = http.MultipartRequest('POST', apiUrl);
  // Attach the file in the request
  final file = await http.MultipartFile.fromPath('doc', upfile.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  addproj.files.add(file);
  addproj.fields['p_name'] = pname.toString();
  addproj.fields['client'] = client.toString();
  addproj.fields['start'] = strtdte.toString();
  addproj.fields['end'] = enddate.toString();
  addproj.fields['rate'] = totprocst.toString();
  addproj.fields['description'] = descrptn.toString();

  try {
    addproj.headers.addAll(headers);
    final streamedResponse = await addproj.send();
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

Future viewmoneytrnsfr(token) async {
  final String url = NetworkUtils.moneytrnsfrview;
  final res = await http.get(Uri.parse(url), headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  });
  var viewmony = json.decode(res.body);
  return viewmony;
}

Future addLabour(token, fname, lname, id, joinedate, phone, des) async {
  var url = Uri.parse(NetworkUtils.addLabour);
  var response = await http.post(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer " + token.toString(),
  }, body: {
    "fname": fname.toString(),
    "lname": lname.toString(),
    "id": id.toString(),
    "joindate": joinedate.toString(),
    "phone": phone.toString(),
    "des": des.toString(),
  });
  print("status code :" + response.statusCode.toString());
  var data = json.decode(response.body);
  return data;
}
