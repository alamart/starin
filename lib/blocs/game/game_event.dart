import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class InitGame extends GameEvent {

  @override
  List<Object> get props => [];
}

class EndGame extends GameEvent {

  const EndGame();

  @override
  List<Object> get props => [];
}
