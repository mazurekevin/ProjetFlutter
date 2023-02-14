import 'package:projet_flutter/models/language.dart';

import '/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ServiceLanguage {
  Future<List<Language>?> getLanguages() async {
    String url =
        "https://api.themoviedb.org/3/configuration/languages?api_key=${globals.apiKey}";

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var json = response.body;
        List<Language> listLanguage = languageFromJson(json);
        listLanguage.removeAt(0);
        listLanguage.sort((a, b) => a.englishName.compareTo(b.englishName));
        return listLanguage;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}