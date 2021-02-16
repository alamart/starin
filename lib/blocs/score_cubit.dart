import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(ScoreState(score: 0));

  void setNewScore(int newScore) =>
      emit(ScoreState(score: state.score > newScore ? state.score : newScore));
}
