import 'dart:convert';
List<Comment> listCommentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));
Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.iduser,
    required this.idmovie,
    required this.firstname,
    required this.lastname,
    required this.content,
  });

  int id;
  int iduser;
  int idmovie;
  String firstname;
  String lastname;
  String content;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    iduser: json["iduser"],
    idmovie: json["idmovie"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iduser": iduser,
    "idmovie": idmovie,
    "firstname": firstname,
    "lastname": lastname,
    "content": content,
  };
}