import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetQuiz;
  Result(this.score, this.resetQuiz);

  String get resultText {
    String text;

    if (score <= 8) {
      text = "You are awesome and innocent!";
    } else if (score <= 12) {
      text = "Pretty likeable!";
    } else if (score <= 16) {
      text = "You are strange!";
    } else {
      text = "You are so bad!";
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Column(
        children: [
          Text(
            "$resultText Your score is: $score",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(onPressed: resetQuiz, child: Text("Restart quiz"))
        ],
      ),
    );
  }
}
