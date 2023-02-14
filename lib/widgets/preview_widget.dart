import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/movie_preview.dart';

class PreviewWidget extends StatefulWidget {
  final MoviePreview moviePreview;

  const PreviewWidget({
    Key? key,
    required this.moviePreview,
  }) : super(key: key);

  @override
  _PreviewWidgetState createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  late Widget posterImage;
  bool isLiked = false;
  Icon liked = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    var releaseDate = DateFormat('d MMMM yyyy')
        .format(DateTime.parse(widget.moviePreview.releaseDate));

    if (widget.moviePreview.posterPath == "") {
      posterImage = const Icon(
        Icons.movie,
      );
    } else {
      posterImage = Image.network(
        'https://image.tmdb.org/t/p/w500${widget.moviePreview.posterPath}',
        fit: BoxFit.cover,
      );
    }

    return Container(
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
        width: 200,
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: posterImage,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isLiked) {
                        isLiked = false;
                        liked = const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        );
                      } else {
                        isLiked = true;
                        liked = const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        );
                      }
                    });
                  },
                  icon: liked,
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    widget.moviePreview.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    releaseDate,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.moviePreview.voteAverage.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
