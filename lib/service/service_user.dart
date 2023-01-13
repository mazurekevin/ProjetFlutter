import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/login.dart';
import '../models/user.dart';


class ServiceUser{
  Future<int> createUser(String firstname, String lastname, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8082/api/user/createUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password
      }),
    );

    if(response.statusCode==200){
      return response.statusCode;
    }else{
      return response.statusCode;
    }
  }

  Future<User?> login(Login login) async {
    var response = await http.post(
      Uri.parse('http://localhost:8082/api/user/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': login.email!,
        'password': login.password!
      }),
    );
    if(response.statusCode==200){
      var json = response.body;
      return userFromJson(json);
    }

    return null;
  }



}