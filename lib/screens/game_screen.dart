import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:starin/blocs/game/game_bloc.dart';
import 'package:starin/blocs/game/game_event.dart';
import 'package:starin/blocs/game/game_state.dart';
import 'package:starin/blocs/question/question_bloc.dart' as questionBloc;
import 'package:starin/blocs/score/score_cubit.dart';

class GameScreen extends StatelessWidget {
  int timer = 60;
  String imagePath = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<questionBloc.QuestionBloc>(
        create: (context) => questionBloc.QuestionBloc(),
        child: Scaffold(
          backgroundColor: Color(0xFF073B4C),
          body: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 50),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 50),
                    alignment: Alignment.topRight,
                    child: BlocBuilder<ScoreCubit, ScoreState>(
                      builder: (context, state) {
                        return Text(
                          "Best score : " + state.score.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: BlocListener<GameBloc, GameState>(
                  listener: (context, state) {
                    if (state is GameError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        if (state is GameInit) {
                          BlocProvider.of<GameBloc>(context).add(InitGame());
                          return buildInitGameState();
                        } else if (state is GameLoaded) {
                          return buildLoadedGameState(context, state);
                        } else if (state is GameEnded) {
                          BlocProvider.of<ScoreCubit>(context)
                              .setNewScore(state.currentScore);
                          return buildEndedGameState(context);
                        }
                        return buildInitGameState();
                      }),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildInitGameState() {
    return Center(
        child: Text("Ready? Go",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
            textAlign: TextAlign.center));
  }

  Widget buildEndedGameState(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Center(
            child: Text("Game Over",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center)),
        Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Highest score",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            BlocBuilder<ScoreCubit, ScoreState>(
              builder: (context, state) {
                return Text(
                  state.score.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            )
          ],
        ),
        IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(InitGame());
            })
      ],
    );
  }

  Widget buildLoadedGameState(BuildContext context, GameLoaded state) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              CountdownTimer(
                  endTime: DateTime
                      .now()
                      .millisecondsSinceEpoch + 1000 * timer,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      BlocProvider.of<GameBloc>(context)
                          .add(EndGame());
                      return SizedBox(
                          height: 200.0,
                          child: Text(
                            'Game over',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ));
                    }
                    return SizedBox(
                        height: 200.0,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  strokeWidth: 15,
                                  value: time.sec / timer,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${time.sec}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ));
                  }),
            ],
          ),
        ),
        SizedBox(height: 40),
        BlocListener<questionBloc.QuestionBloc, questionBloc.QuestionState>(
            listener: (listenerContext, listenerState) {
              if (listenerState is questionBloc.QuestionAnswered) {
                if (listenerState.status == questionBloc.AnswerStatus.SUCCESS) {
                  showAnswerMessage(
                      listenerContext, Colors.green, "Correct !");
                } else {
                  showAnswerMessage(listenerContext, Colors.red, "Wrong !");
                }
              }
            }, child: BlocBuilder<questionBloc.QuestionBloc,
            questionBloc.QuestionState>(builder: (context, questionState) {
          if (questionState is questionBloc.QuestionInitial) {
            BlocProvider.of<questionBloc.QuestionBloc>(context)
                .add(questionBloc.LoadQuestion(state.movies, state.actors));
            return CircularProgressIndicator();
          } else if (questionState is questionBloc.QuestionLoaded) {
            return buildBodyQuestion(context, questionState);
          } else if (questionState is questionBloc.QuestionAnswered) {
            gameBloc.score += questionState.score;
            BlocProvider.of<questionBloc.QuestionBloc>(context)
                .add(questionBloc.LoadQuestion(state.movies, state.actors));
          }
          return buildInitGameState();
        })),
      ],
    );
  }

  void showAnswerMessage(BuildContext listenerContext, Color color,
      String message) {
    ScaffoldMessenger.of(listenerContext).showSnackBar(SnackBar(
        backgroundColor: color,
        duration: Duration(milliseconds: 500),
        content: Text(message,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ))));
  }

  Widget buildBodyQuestion(BuildContext context,
      questionBloc.QuestionLoaded state) {
    var actorProfile =
    state.actor.profilePath != null ? state.actor.profilePath : "";
    var moviePoster =
    state.movie.posterPath != null ? state.movie.posterPath : "";
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Center(
            child: Text("Your score " + gameBloc.score.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                )),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Center(
                child: Text("Did",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                width: 50,
              ),
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  ThumbnailCard(
                    title: state.actor.name,
                    image: imagePath + actorProfile,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Text("Star in",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 50,
              ),
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  ThumbnailCard(
                    title: state.movie.title,
                    image: imagePath + moviePoster,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Text("?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 40),
          Center(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<questionBloc.QuestionBloc>(context).add(
                        questionBloc.AnswerQuestion(
                            state.movie, state.actor, true));
                  },
                  child: Text("YES",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<questionBloc.QuestionBloc>(context).add(
                        questionBloc.AnswerQuestion(
                            state.movie, state.actor, false));
                  },
                  child: Text("NO",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ],
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(left: 50),
      alignment: Alignment.topRight,
      child: BlocBuilder<ScoreCubit, ScoreState>(
        builder: (context, state) {
          return Text(
            "Best score : " + state.score.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w100,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          );
        },
      ),
      margin: EdgeInsets.only(top: 50),
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  final String title;
  final String image;

  const ThumbnailCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        children: <Widget>[
          getImage(image),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Image getImage(String image) {
    return Image.network(image, height: 250,
    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace)
    {
      return Image.asset("assets/images/image-not-found.png", height: 250);
    });
  }
}
