part of 'score_cubit.dart';


class ScoreState extends Equatable{
  int score;

  ScoreState({
   @required this.score
  });

  @override
  List<Object> get props => [this.score];
}
