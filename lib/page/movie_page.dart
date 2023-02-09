import 'package:flutter/material.dart';

import '../widgets/header_container.dart';

class MoviePage extends StatefulWidget {
  final int? movieId;
  final String? movieTitle;

  const MoviePage({
    Key? key,
    this.movieId,
    this.movieTitle,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
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
                    Container(),
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
