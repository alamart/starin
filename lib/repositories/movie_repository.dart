import 'package:starin/models/movie.dart';
import 'package:starin/models/person.dart';
import 'package:starin/resources/api_provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

abstract class GenericMovieRepository{
  Future<List<Movie>> fetchPopularMovies();
  Future<List<Movie>> fetchBestMovies();
  Future<List<Person>> fetchMovieActors(int movieId);
}

class MovieRepository implements GenericMovieRepository{
  final Movies _movieApiProvider = ApiProvider().getMoviesProvider();

  Future<List<Movie>> fetchPopularMovies() async {
    Map<dynamic, dynamic> queryResults = await _movieApiProvider.getPouplar();
    return _getListFromMovieResults(queryResults);
  }

  Future<List<Movie>> fetchBestMovies() async {
    Map<dynamic, dynamic> queryResults = await _movieApiProvider.getTopRated();
    return _getListFromMovieResults(queryResults);
  }

  Future<List<Person>> fetchMovieActors(int movieId) async {
    Map<dynamic, dynamic> queryResults =
        await _movieApiProvider.getCredits(movieId);
    return _getListFromPersonResults(queryResults)
        .where((actor) => actor.occupation == 'Acting')
        .toList();
  }

  List<Movie> _getListFromMovieResults(Map<dynamic, dynamic> queryResults) {
    Iterable popularMovies = queryResults['results'];
    if (popularMovies.isEmpty) {
      throw Exception('Failed to get popular movies from API');
    }
    return popularMovies.map((json) => Movie.fromJson(json)).toList();
  }

  List<Person> _getListFromPersonResults(Map<dynamic, dynamic> queryResults) {
    Iterable persons = queryResults['cast'];
    if (persons.isEmpty) {
      throw Exception('Failed to get results from API');
    }
    return persons.map((json) => Person.fromJson(json)).toList();
  }
}

class NetworkError {}
