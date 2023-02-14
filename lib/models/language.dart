import 'dart:convert';

List<Language> languageFromJson(String str) => List<Language>.from(json.decode(str).map((x) => Language.fromJson(x)));

String languageToJson(List<Language> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Language {
  Language({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  String iso6391;
  String englishName;
  String name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    iso6391: json["iso_639_1"],
    englishName: json["english_name"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391,
    "english_name": englishName,
    "name": name,
  };
}