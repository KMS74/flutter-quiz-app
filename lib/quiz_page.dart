import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_helper.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/result_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var apiUrl =
      'https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=multiple';
  QuizHelper quizHelper;
  int currentQuestion = 0;
  int score = 0;
  int questionNumber = 1;
  List<String> questionOptions = [];
  int totalSeconds = 15;
  int elapsedSeconds = 0; // variable that contain time that passes over time
  Timer timer;

  // doing long-running opertaion (get the data from the server)
  void fetchQuizData() async {
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var body = response.body;
      var json = jsonDecode(body);
      setState(() {
        quizHelper = QuizHelper.fromJson(json);
        questionOptions = quizHelper.results[currentQuestion].incorrectAnswers;
        questionOptions.add(quizHelper.results[currentQuestion].correctAnswer);
        questionOptions.shuffle();
        initTimer();
      });
      print('$json');
    } else {
      print('some thing go wrong');
    }
  }

  // checking the answer
  checkAnswer(String answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score++; // increment score by one
      print('correct');
    } else {
      print('wrong');
    }
    changeQuestion();
  }

  // Timer Functionality
  void initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        print('timer completed');
        changeQuestion();
        t.cancel();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  void changeQuestion() {
    timer.cancel(); // cancelling the timer
    // check if it is the last question
    if (currentQuestion == quizHelper.results.length - 1) {
      // end of quiz
      // go to the result page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultPage(score: score,)));
      print('quiz completed');
      print('Score : $score');
    } else {
      setState(() {
        currentQuestion++;
      });
      questionOptions = quizHelper.results[currentQuestion].incorrectAnswers;
      questionOptions.add(quizHelper.results[currentQuestion].correctAnswer);
      questionOptions.shuffle();
      initTimer();
    }
  }

  @override
  void initState() {
    fetchQuizData(); // calling the method once the widget is created;
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel(); // cancel the timer when widget is destroyed(desposeing)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/icon-circle.png',
                        width: 60,
                        height: 60,
                      ),
                      // Timer Functionality
                      Text(
                        '$elapsedSeconds s',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                //  Question
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Q. ${quizHelper.results[currentQuestion].question}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Question Options
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    children: questionOptions.map((option) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Color(0xFF511AA8),
                          colorBrightness: Brightness.dark,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          onPressed: () {
                            checkAnswer(option);
                          },
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 7,
          ),
        ),
      );
    }
  }
}
