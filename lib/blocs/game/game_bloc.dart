import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starin/blocs/game/game_event.dart';
import 'package:starin/blocs/game/game_state.dart';
import 'package:starin/models/movie.dart';
import 'package:starin/models/person.dart';
import 'package:starin/repositories/movie_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GenericMovieRepository movieRepository;
  int score = 0;

  GameBloc(this.movieRepository) : super(GameInit());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    yield GameLoading();
    if (event is InitGame) {
      score = 0;
      try {
        List<Movie> movies = await movieRepository.fetchPopularMovies();
        final List<Person> allActors = [];
        movies.forEach((movie) async {
          List<Person> currentMovieActors =
              await movieRepository.fetchMovieActors(movie.id);
          movie.cast = currentMovieActors;
          allActors.addAll(currentMovieActors);
        });
        await Future.delayed(const Duration(seconds: 1), () {});
        yield GameLoaded(movies, allActors);
      } on NetworkError {
        yield GameError("It seems you are offline");
      }
    } else if (event is EndGame) {
      yield GameEnded(score);
    }
  }
}
