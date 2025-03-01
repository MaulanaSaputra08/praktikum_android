import 'package:praktikummobile/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:praktikummobile/home_screen.dart';
import 'package:praktikummobile/question_screen.dart';
import 'package:praktikummobile/datas/question.dart';
import 'package:praktikummobile/profile.dart'; // Pastikan path ini benar

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  final List<String> selectedAnswer = [];

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void switchToProfileScreen() {
    setState(() {
      activeScreen = 'profile-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer.clear(); // Perbaikan di sini
      activeScreen = 'start-screen'; // Kembali ke layar awal
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(
      switchScreen,
      switchToProfileScreen, // Fungsi untuk berpindah ke layar profil
      key: const Key('home-screen'),
    );

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer, // chooseAnswer sudah diterima dengan benar
        key: const Key('question-screen'),
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        choosenAnswers: selectedAnswer,
        onRestart: restartQuiz, // Perbaikan di sini
      );
    }

    if (activeScreen == 'profile-screen') {
      screenWidget = const Profile();
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}