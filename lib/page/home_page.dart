import 'package:flutter/material.dart';
import 'package:projet_flutter/models/movie_preview.dart';
import 'package:projet_flutter/service/service_movie.dart';

import '../widgets/header_container.dart';
import '../widgets/preview_widget.dart';
import 'movie_page.dart';
import '/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MoviePreview> _moviesPreview = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    globals.page = 1;
    getData();
  }

  getData() async {
    _moviesPreview += (await ServiceMovie().getMovies())!;
    if (_moviesPreview.isNotEmpty) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            const HeaderContainer(text: "Home", height: 0.10),
            Expanded(
              flex: 1,
              child: Visibility(
                visible: _isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  itemCount: _moviesPreview.length,
                  itemBuilder: (context, index) {
                    if (index == 15 * globals.page) {
                      globals.page++;
                      getData();
                    }
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoviePage(
                                  movieId: _moviesPreview[index].id.toInt(),
                                  movieTitle: _moviesPreview[index].title,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  PreviewWidget(
                                    moviePreview: _moviesPreview[index],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
