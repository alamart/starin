part of 'question_bloc.dart';

enum AnswerStatus { SUCCESS, FAIL }

abstract class QuestionState extends Equatable {
  const QuestionState();
}

class QuestionInitial extends QuestionState {
  @override
  List<Object> get props => [];
}

class QuestionLoaded extends QuestionState {
  final Movie movie;
  final Person actor;

  QuestionLoaded(this.movie, this.actor);

  @override
  List<Object> get props => [movie, actor];
}

class QuestionAnswered extends QuestionState {
  final int score;
  final AnswerStatus status;

  QuestionAnswered(this.score, this.status);

  @override
  List<Object> get props => [score, status];
}

class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);

  @override
  List<Object> get props => [message];
}
