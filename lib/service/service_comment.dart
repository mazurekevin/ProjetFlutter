import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:projet_flutter/models/comment.dart';

class ServiceComment{
  Future<Comment> createComment(String firstname, String lastname, int idmovie, int iduser, String content) async {
    final response = await http.post(
      Uri.parse('http://localhost:8082/api/comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstname': firstname,
        'lastname': lastname,
        'idmovie': idmovie,
        'iduser': iduser,
        'content': content
      }),
    );

    if(response.statusCode==201){
      var json = response.body;
      return commentFromJson(json);
    }else{
      var json = response.body;
      return commentFromJson(json);
    }
  }

  Future<List<Comment>?> getCommentsByIdmovie(int idmovie) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8082/api/comment/idmovie/${idmovie}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return ListCommentFromJson(json);
    }
    return null;
  }
}