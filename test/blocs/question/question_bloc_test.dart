import 'package:flutter_test/flutter_test.dart';
import 'package:starin/blocs/question/question_bloc.dart';

void main(){
  group('Question Bloc test', (){
    QuestionBloc questionBloc;

    setUp((){
      questionBloc = QuestionBloc();
    });

    tearDown((){
      questionBloc.close();
    });

    test('Initial state of QuestionBloc is QuestionInitial', (){
      expect(questionBloc.state, QuestionInitial());
    });

  });
}