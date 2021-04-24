import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/quiz_page.dart';

class ResultPage extends StatelessWidget {
  final int score;
  ResultPage({this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/icon-circle.png',
                  height: 250,
                  width: 250,
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Result',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '$score / 10',
                style: TextStyle(color: Color(0xFFFFBA00), fontSize: 65),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizPage()));
                  },
                  child: Text(
                    'restart'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Color(0xFF511AA8),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'exit'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
