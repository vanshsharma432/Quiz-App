import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CorrectProvider extends ChangeNotifier {
  int correct = 0;
  void increment() {
    correct++;
    notifyListeners();
  }
}
class QuestionsProvider with ChangeNotifier {
  List<dynamic> questions = [];
  void setQuestions(List<dynamic> newQuestions) {
    questions = newQuestions;
    notifyListeners();
  }
}
class AnswersProvider with ChangeNotifier {
  List<String> answers = [];
  void addAnswer(String answer) {
    answers.add(answer);
    notifyListeners();
  }
}