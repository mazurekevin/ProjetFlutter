import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_flutter/models/comment.dart';
import 'package:projet_flutter/globals.dart' as global;
import 'package:projet_flutter/models/movie.dart';
import 'package:projet_flutter/models/movie_provider.dart';
import 'package:projet_flutter/page/profile_page.dart';
import 'package:projet_flutter/service/service_movie.dart';
import 'package:url_launcher/url_launcher.dart';

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
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late int movieId;
  String? movieTitle;
  late Movie? _movie;
  late MovieProvider _movieProvider;
  late Widget providerWidget;
  List<Comment>? comments;
  var isProviderLoaded = false;
  var isMovieLoaded = false;
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getMovie();
    getProviders();
    getComments();
  }

  addComment(String content) async {
    var response = await ServiceComment().createComment(global.user!.firstname,
        global.user!.lastname, widget.movieId, global.user!.id, content);
    if (response != null) {
      setState(() {
        comments?.add(response);
      });
    } else {
      print("erreur");
    }
  }

  getMovie() async {
    _movie = (await ServiceMovie().getMovie(widget.movieId))!;
    if (_movie != null) {
      setState(() {
        isMovieLoaded = true;
      });
    }
  }

  getProviders() async {
    _movieProvider = (await ServiceMovie().getProviders(widget.movieId))!;

    if (_movieProvider.link == "" && _movieProvider.logo == "") {
      providerWidget = const Text(
        "Ce film n'est pas disponible en streaming",
        textAlign: TextAlign.left,
      );
    } else {
      providerWidget = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            _launchURL(_movieProvider.link);
          },
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${_movieProvider.logo}',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
      );
    }

    setState(() {
      isProviderLoaded = true;
    });
  }

  getComments() async {
    comments = await ServiceComment().getCommentsByIdmovie(widget.movieId);
    if (comments != null) {
      /*setState(() {
        isLoaded = true;
      });*/
    }
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var releaseDate = _movie?.releaseDate;

    if (releaseDate != null) {
      releaseDate =
          DateFormat('d MMMM yyyy').format(DateTime.parse(releaseDate));
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            const HeaderContainer(text: "", height: 0.10),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Visibility(
                      visible: isMovieLoaded && isProviderLoaded,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _movie!.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${_movie!.posterPath}',
                                    width: 100,
                                    height: 150,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        releaseDate!,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _movie!.genresToString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _movie!.tagline,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 110,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Disponible sur :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      providerWidget,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                const Text(
                                  'Synopsis',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      _movie!.overview,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: const Color(0xff6d07c5),
                          ),
                          child: Ink(
                            child: const Icon(
                              Icons.comment,
                            ),
                          ),
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
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
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
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ProfilePage(userId: comments![index].iduser)));
                                                  },
                                                );
                                              }),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          TextField(
                                            controller: commentController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(20.0),
                                              hintText:
                                                  'Ajouter un commentaire',
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(4.0),
                                                width: 48.0,
                                                height: 48.0,
                                              ),
                                              suffixIcon: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 4.0),
                                                width: 70.0,
                                                child: IconButton(
                                                  icon: const Icon(Icons.send),
                                                  iconSize: 30.0,
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        addComment(
                                                            commentController
                                                                .text);
                                                        commentController
                                                            .clear();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
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
