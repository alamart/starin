import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starin/blocs/score_cubit.dart';
import 'package:starin/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreCubit>(
        create: (context) => ScoreCubit(),
        child: MaterialApp(
          title: 'Starin',
          home: HomeScreen(),
        )
    );
  }
}

