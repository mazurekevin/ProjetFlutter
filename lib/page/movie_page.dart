import 'dart:html';

import 'package:flutter/material.dart';
import 'package:projet_flutter/models/comment.dart';
import 'package:projet_flutter/globals.dart' as global;

import '../service/service_comment.dart';
import '../widgets/header_container.dart';

class MoviePage extends StatefulWidget {
  final int movieId;
  final String? movieTitle;

  const MoviePage({
    Key? key,
    required this.movieId,
    this.movieTitle,
  }) : super(key: key);

  @override
  State<MoviePage> createState() =>
      _MoviePageState(this.movieId, this.movieTitle);
}

class _MoviePageState extends State<MoviePage> {
  int movieId;
  String? movieTitle;
  List<Comment>? comments;
  var isLoaded = false;
  final commentController = TextEditingController();

  _MoviePageState(this.movieId, this.movieTitle);

  @override
  void initState() {
    super.initState();

    getComments();
  }

  addComment(String content) async {
    var response = await ServiceComment().createComment(global.user!.firstname,
        global.user!.lastname, this.movieId, global.user!.id, content);
    if (response != null) {
      setState(() {
        comments?.add(response);
      });
    } else {
      print("erreur");
    }
  }

  getComments() async {
    comments = await ServiceComment().getCommentsByIdmovie(this.movieId);
    if (comments != null) {
      /*setState(() {
        isLoaded = true;
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    String movieTitle = widget.movieTitle!;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer(text: movieTitle, height: 0.10),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(),
                    Container(
                      child: ElevatedButton(
                        child: const Text('comment'),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: ListView.builder(
                                              itemCount: comments?.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    margin: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    comments![index]
                                                                            .firstname +
                                                                        " ",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    comments![
                                                                            index]
                                                                        .lastname,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                comments![index]
                                                                        .content +
                                                                    "  ",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                );
                                              }),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: commentController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(20.0),
                                                hintText:
                                                    'Ajouter un commentaire',
                                                prefixIcon: Container(
                                                  margin: EdgeInsets.all(4.0),
                                                  width: 48.0,
                                                  height: 48.0,
                                                ),
                                                suffixIcon: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 4.0),
                                                  width: 70.0,
                                                  child: IconButton(
                                                    icon: Icon(Icons.send),
                                                    iconSize: 30.0,
                                                    onPressed: () {
                                                      setState(() {
                                                        addComment(
                                                            commentController
                                                                .text);
                                                        commentController
                                                            .clear();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
