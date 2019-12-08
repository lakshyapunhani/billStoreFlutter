import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest
{
  var url = "192.168.0.110";

  Future<Map> login(String username,String password) async{
    var response = await http.post(createUri('login/'),
        body: json.encode({'username': username, 'password': password}),headers: await getHeaders());
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
    return new Uri(scheme: 'http', host: url, port: 8080, path: path, queryParameters: params).toString();
  }

  Future<Map<String, String>> getHeaders() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
    return {
//      HttpHeaders.authorizationHeader: preferences.get('token'),
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }
}