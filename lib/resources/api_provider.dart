import 'package:tmdb_api/tmdb_api.dart';

class ApiProvider{

  final TMDB tmdb = TMDB(ApiKeys('9a941aecb762f71017a76e8fb2759214', 'apiReadAccessTokenv4'));

  Movies getMoviesProvider(){
    return tmdb.v3.movies;
  }

  People getPersonsProvider(){
    return tmdb.v3.people;
  }
}