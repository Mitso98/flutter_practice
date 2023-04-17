import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback handler;
  final String answerText;
  final int score;
  const Answer({this.handler, this.answerText, this.score});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handler,
      child: Text(answerText),
    );
  }
}
