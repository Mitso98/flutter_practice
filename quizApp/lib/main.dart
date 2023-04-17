import 'package:flutter/material.dart';

import './quiz.dart';
import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _score = 0;
  var _questionsIdx = 0;
  final questions = const [
    {
      "question": "What's your fav color?",
      "answer": [
        {"text": "Red", "score": 5},
        {"text": "Green", "score": 1},
        {"text": "Black", "score": 10},
      ]
    },
    {
      "question": "What's your fav animal?",
      "answer": [
        {"text": "Lion", "score": 5},
        {"text": "Rabbit", "score": 1},
        {"text": "Snake", "score": 10},
      ]
    },
    {
      "question": "What's your fav team?",
      "answer": [
        {"text": "Liverpool", "score": 5},
        {"text": "Celtic", "score": 1},
        {"text": "AC Milan", "score": 10},
      ]
    },
  ];

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _questionsIdx = 0;
    });
  }

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionsIdx += 1;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("First App"),
        ),
        body: _questionsIdx < questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: questions,
                questionsIdx: _questionsIdx,
              )
            : Result(_score,_resetQuiz),
      ),
    );
  }
}
