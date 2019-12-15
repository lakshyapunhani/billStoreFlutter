import 'dart:convert';
import 'dart:io';

import 'SessionManager.dart';
import 'package:http/http.dart' as http;

class HttpRequest
{
  var url = "192.168.0.110";

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

  Future<String> addProduct(String productName,String description,
      String rate) async{
    var userId = await getUserId();
    var response = await http.post(createUri
      ('product/',id: userId),
        body: json.encode({'name':productName,
          'rate':double.parse(rate),
          'description':description,
          'quantity':0}),
        headers: await getHeaders());
    if(response.statusCode == 201)
    {
      return response.body;
    }
    return throw (response.statusCode.toString());
  }

  Future<List> getAllProducts() async{
    var userId = await getUserId();
    var response = await http.get(createUri('product/',
        id: userId),
        headers: await getHeaders());
    if(response.statusCode == 200)
    {
      return json.decode(response.body);
    }
    return throw (response.statusCode.toString());
  }

  Future<String> addClient(String name,String username,
      String address,String email,String gstNumber) async{
    var userId = await getUserId();
    var response = await http.post(createUri
      ('contact/',id: userId),
        body: json.encode({'name':name,
          'username':username,
          'address':address,
          'email':email,'gstNumber':gstNumber}),
        headers: await getHeaders());
    if(response.statusCode == 201)
    {
      return response.body;
    }
    return throw (response.statusCode.toString());
  }

  Future<List> getAllClients() async{
    var userId = await getUserId();
    var response = await http.get(createUri('contact/',
        id: userId),
        headers: await getHeaders());
    if(response.statusCode == 200)
    {
      return json.decode(response.body);
    }
    return throw (response.statusCode.toString());
  }

  String createUri(String path, {String id, Map params}) {
    if (id != null) {
      path += id;
    }
    return new Uri(scheme: 'http',
        host: url,
        port: 8080,
        path: path,
        queryParameters: params).toString();
  }

  Future<Map<String, String>> getHeaders() async {
    return {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }
}