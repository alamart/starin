import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:starin/blocs/score/score_cubit.dart';

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
          ),
          SizedBox(height: 40),
          Center(
            child: Text("Did",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                )),
          ),
          SizedBox(height: 40),
          Center(
            child: Row(
              children: [
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    ThumbnailCard(
                      title: "Robert Downey Jr",
                      image: "assets/images/georgewbush.jpg",
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
                      title: "The Avengers",
                      image: "assets/images/film.jpg",
                    ),
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.thumb_up),
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
                  onPressed: () {},
                  child: Icon(Icons.thumb_down),
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

class ThumbnailCard extends StatelessWidget {
  final String title;
  final String image;

  const ThumbnailCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 200),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}