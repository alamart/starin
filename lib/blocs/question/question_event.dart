part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();
}

class LoadQuestion extends QuestionEvent {
  final List<Movie> movies;
  final List<Person> actors;

  LoadQuestion(this.movies, this.actors);

  @override
  List<Object> get props => [];
}

class AnswerQuestion extends QuestionEvent {
  final Movie movie;
  final Person actor;
  final bool answer;

  AnswerQuestion(this.movie, this.actor, this.answer);

  @override
  List<Object> get props => [movie, actor, answer];
}
