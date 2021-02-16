import 'package:flutter_test/flutter_test.dart';
import 'package:starin/blocs/score_cubit.dart';

void main(){
  group('Score cubit test', (){
    ScoreCubit scoreCubit;

    setUp((){
      scoreCubit = ScoreCubit();
    });

    tearDown((){
      scoreCubit.close();
    });

    test('Initial state of ScoreCubit is ScoreCubit with a zero score', (){
      expect(scoreCubit.state, ScoreState(score: 0));
    });

    test('Score goes from 0 to 1 when being updated', (){
      expect(scoreCubit.state, ScoreState(score: 0));
      scoreCubit.setNewScore(1);
      expect(scoreCubit.state, ScoreState(score: 1));
    });

    test('Score stays at 1 when being updated with a 0 score', (){
      scoreCubit.setNewScore(1);
      scoreCubit.setNewScore(0);
      expect(scoreCubit.state, ScoreState(score: 1));
    });
  });
}