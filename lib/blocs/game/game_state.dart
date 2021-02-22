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
  final List<Person> actors;

  GameLoaded(this.movies, this.actors);

  @override
  List<Object> get props => [movies];

}

class GameEnded extends GameState{
  final int currentScore;

  GameEnded(this.currentScore);

  @override
  List<Object> get props => [currentScore];

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