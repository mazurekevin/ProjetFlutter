class MovieProvider {
  final String link;
  final String logo;

  MovieProvider({
    required this.link,
    required this.logo,
  });

  factory MovieProvider.fromJson(Map<String, dynamic> json) {
    if (json['flatrate'] == null) {
      return MovieProvider(
        link: "",
        logo: "",
      );
    } else {
      return MovieProvider(
        link: json['link'],
        logo: json['flatrate'][0]['logo_path'],
      );
    }
  }

  static MovieProvider movieProvider(json) {
    MovieProvider movieProvider;
    if (json['FR'] != null) {
      movieProvider = MovieProvider.fromJson(json['FR']);
    } else {
      movieProvider = MovieProvider(
        link: "",
        logo: "",
      );
    }
    return movieProvider;
  }
}
