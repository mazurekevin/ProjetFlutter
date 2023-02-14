import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie_preview.dart';
import '../service/service_movie.dart';
import '../widgets/header_container.dart';
import '../widgets/preview_widget.dart';
import 'movie_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  List<MoviePreview> movies = [];

  getData(String search) async {
    print("1");
    var _moviesPreview = (await ServiceMovie().searchMovies(search))!;
    if(_moviesPreview.isNotEmpty){
      setState(() {
        movies = _moviesPreview;
      });
      print(_moviesPreview.length);
      for (var i = 0; i < _moviesPreview.length; i++) {
        print(_moviesPreview[i].title);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            const HeaderContainer(text: "Search", height: 0.10),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: 'Search',
                suffixIcon: Container(
                  margin: EdgeInsets.only(
                      right: 4.0),
                  width: 70.0,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    onPressed: () {
                      setState(() {
                        getData(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context,index){
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviePage(
                            movieId: movies[index].id.toInt(),
                            movieTitle: movies[index].title,
                          ),
                        ),
                      );
                    },

                    child: Column(
                      children: <Widget>[
                        PreviewWidget(
                          moviePreview: movies[index],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            ),
          ],
        ),

      ),
    );
  }
}
