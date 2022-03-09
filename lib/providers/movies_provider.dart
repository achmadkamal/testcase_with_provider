import 'package:flutter/foundation.dart';
import 'package:testcase_with_provider/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  final String _baseUrl =
      'https://api.themoviedb.org/3/trending/all/day?api_key=0bc9e6490f0a9aa230bd01e268411e10';

  MoviesModel _movies = MoviesModel();
  MoviesModel get movies => _movies;

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<dynamic> getMovies() async {
    try {
      final url = Uri.parse(_baseUrl);
      final response = await http.get(url);
      final data = moviesModelFromJson(response.body);

      if (response.statusCode == 200) {
        _movies = data;
        notifyListeners();

        return _movies;
      } else {
        return 'error';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
