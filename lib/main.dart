import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/quiz_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'ProductSans',
          scaffoldBackgroundColor: Color(0xFF2D046E)),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/icon-circle.png',
                  height: 300,
                  width: 300,
                ),
              ),
              Text(
                'Quiz',
                style: TextStyle(color: Color(0xFFA20C8E), fontSize: 80),
              ),
              SizedBox(height: 70),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Color(0xFFFFBA00),
                  onPressed: () {
                    // go to quiz page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizPage()));
                  },
                  child: Text(
                    'play'.toUpperCase(),
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
