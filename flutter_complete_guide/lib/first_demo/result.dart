import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;

  Result(this.resultScore, this.resetQuiz);

  String get resultPhrase{
    var resultText = 'You did it';

    if (resultScore <= 12) {
      resultText = 'You are awesome and innocent!';
    } else if (resultScore <= 18) {
      resultText = 'Pretty likeable!';
    } else {
      resultText = 'You are god?';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text('Restart Quiz!'), onPressed: resetQuiz, color: Colors.blue,)
        ],
      ),
    );
  }
}
