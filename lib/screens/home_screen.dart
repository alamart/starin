import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starin/blocs/game/game_bloc.dart';
import 'package:starin/blocs/score/score_cubit.dart';
import 'package:starin/repositories/movie_repository.dart';
import 'package:starin/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF073B4C),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "Starin",
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            margin: EdgeInsets.only(top: 50),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Welcome to the quizz ! You'll be asked a series of \"Yes or No\" questions.\nAnswer as many as you can in the allowed time ! Good luck !",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            margin: EdgeInsets.only(top: 50),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: BlocBuilder<ScoreCubit, ScoreState>(
              builder: (context, state) {
                return Text(
                  "${state.score}\nBest score",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            margin: EdgeInsets.only(top: 50),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<ScoreCubit>(context),
                          child: BlocProvider<GameBloc>(
                              create: (context) =>
                                  GameBloc(MovieRepository()),
                              child: GameScreen()),
                        )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              child: Text("Start"))
        ],
      ),
    );
  }
}
