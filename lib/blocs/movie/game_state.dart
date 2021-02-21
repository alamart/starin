import 'package:equatable/equatable.dart';
import 'package:starin/models/movie.dart';
import 'package:starin/models/person.dart';

abstract class GameState extends Equatable{
  const GameState();
}

class GameInit extends GameState{
  @override
  List<Object> get props => [];

}

class GameLoading extends GameState{
  @override
  List<Object> get props => [];

}

class GameLoaded extends GameState{
  final List<Movie> movies;

  GameLoaded(this.movies);

  @override
  List<Object> get props => [movies];

}

class GameError extends GameState{
  final String message;

  GameError(this.message);

  @override
  List<Object> get props => [message];
}

class QuestionLoading extends GameState{

  @override
  List<Object> get props => [];
}

class QuestionLoaded extends GameState{
  final Movie movie;

  final Person actor;

  QuestionLoaded(this.movie, this.actor);

  @override
  List<Object> get props => [movie, actor];

}