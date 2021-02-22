import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starin/models/movie.dart';
import 'package:starin/models/person.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  int _scoreByCorrectAnswer = 1;
  QuestionBloc() : super(QuestionInitial());

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    yield QuestionInitial();
    if (event is LoadQuestion) {
        Movie randomMovie = (event.movies.toList()..shuffle()).first;
        List<Person> poolMovieActors = [(randomMovie.cast.toList()..shuffle()).first];
        poolMovieActors.add((event.actors.toList()..shuffle()).first);
        Person randomActor = (poolMovieActors.toList()..shuffle()).first;
        yield QuestionLoaded(randomMovie, randomActor);
    } else if (event is AnswerQuestion) {
      if(event.movie.cast.contains(event.actor) == event.answer){
        yield QuestionAnswered(_scoreByCorrectAnswer, AnswerStatus.SUCCESS);
      }
      else{
        yield QuestionAnswered(0, AnswerStatus.FAIL);
      }
    }
  }
}
