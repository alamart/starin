import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:starin/blocs/score_cubit.dart';

class GameScreen extends StatelessWidget {
  int timer = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                CountdownTimer(
                    endTime:
                        DateTime.now().millisecondsSinceEpoch + 1000 * timer,
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if (time == null) {
                        return Text(
                          'Game over',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }
                      return SizedBox(
                          height: 200.0,
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 150,
                                  height: 150,
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
          )
        ],
      ),
    );
  }
}
