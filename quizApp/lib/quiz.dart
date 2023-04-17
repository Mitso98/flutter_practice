import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final int questionsIdx;
  final Function answerQuestion;
  final List<Map<String, Object>> questions;

  const Quiz({
    @required this.answerQuestion,
    @required this.questions,
    @required this.questionsIdx,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(questions[questionsIdx]["question"]),
        ...(questions[questionsIdx]["answer"] as List<Map<String, Object>>)
            .map((text) {
          return Answer(
            handler: () => answerQuestion(text["score"]),
            answerText: text["text"],
            score: text["score"],
          );
        }).toList()
      ],
    );
  }
}
