
import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable{
  const GameEvent();
}

class InitGame extends GameEvent {
  final int bestScore;

  const InitGame(this.bestScore);

  @override
  List<Object> get props => [bestScore];

}

class EndGame extends GameEvent {
  final int currentScore;

  const EndGame(this.currentScore);

  @override
  List<Object> get props => [currentScore];

}