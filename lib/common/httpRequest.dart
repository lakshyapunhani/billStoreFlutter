import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:billstore/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest
{
  var url = "192.168.0.118";

  Future<Map> login(String username,String password) async{
    var response = await http.post(createUri('login/'),
        body: json.encode
          ({'username': username, 'password': password}),
        headers: await getHeaders());
    if(response.statusCode == 200)
    {
      return json.decode(response.body);
    }
    return throw (response.statusCode.toString());
  }

  Future<Map> signUp(String companyName,String companyAddress
      ,String companyGst,String username, String password) async{
    var response = await http.post(createUri('user'),
        body: json.encode({'username': username,
          'password': password,'name':companyName,'address':companyAddress
        ,'gstNumber':companyGst,'email':"lakshya@gmail.com"})
        ,headers: await getHeaders());
    if(response.statusCode == 201)
    {
      return json.decode(response.body);
    }
    return throw (response.statusCode.toString());
  }

  Future<Map> addProduct(String productName,String description,
      double rate) async{
    var response = await http.post(createUri('product'),
    body: json.encode({'name':productName}),headers: await getHeaders());
  }

  String createUri(String path, {String id, Map params}) {
    if (id != null) {
      path += id;
    }
    return new Uri(scheme: 'http', host: url, port: 8080, path: path, queryParameters: params).toString();
  }

  Future<Map<String, String>> getHeaders() async {
    return {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }
}