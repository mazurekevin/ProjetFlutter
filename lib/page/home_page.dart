import 'package:flutter/material.dart';
import 'package:projet_flutter/models/movie_preview.dart';
import 'package:projet_flutter/service/service_movie.dart';

import '../widgets/header_container.dart';
import 'movie_page.dart';

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
    getData();
  }

  getData() async {
    _moviesPreview = (await ServiceMovie().getMovies())!;
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
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 30),
                child: Visibility(
                  visible: _isLoaded,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 75.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    itemCount: _moviesPreview.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxHeight: 200,
                                maxWidth: 200,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MoviePage(
                                        movieId:
                                            _moviesPreview[index].id.toInt(),
                                        movieTitle: _moviesPreview[index].title,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${_moviesPreview[index].posterPath}",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _moviesPreview[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(_moviesPreview[index].releaseDate),
                                Text(_moviesPreview[index]
                                    .voteAverage
                                    .toString()),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
