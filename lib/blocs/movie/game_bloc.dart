import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starin/blocs/movie/game_event.dart';
import 'package:starin/blocs/movie/game_state.dart';
import 'package:starin/models/movie.dart';
import 'package:starin/repositories/movie_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState>{
  final MovieRepository movieRepository;

  GameBloc(GameInit initialState, this.movieRepository) : super(initialState);

  @override
  Stream<GameState> mapEventToState(GameEvent event) async*{
    yield GameLoading();
    if(event is InitGame){
      try{
        final List<Movie> movies = await movieRepository.fetchPopularMovies();
        yield GameLoaded(movies);
      } on NetworkError {
        yield GameError("It seems you are not online");
      }
    }
  }

}