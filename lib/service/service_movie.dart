import 'dart:convert';

import 'package:projet_flutter/models/movie_preview.dart';

import '/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ServiceMovie {
  Future<List<MoviePreview>?> getMovies() async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=${globals.apiKey}&language=fr-FR&sort_by=popularity.desc&page=${globals.page}";

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var json = response.body;
        List<MoviePreview> listMoviePreview = MoviePreview.listMoviePreview(jsonDecode(json)['results']);
        return listMoviePreview;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
