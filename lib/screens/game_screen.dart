import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:starin/blocs/score_cubit.dart';

class GameScreen extends StatelessWidget {
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
            alignment: Alignment.bottomCenter,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: Container(
                margin: EdgeInsets.all(8),
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CountdownTimer(
                  endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      return Text(
                        'Game over',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                    return Text(
                      '${time.sec}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
