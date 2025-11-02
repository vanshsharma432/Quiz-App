import 'package:html_unescape/html_unescape.dart';
import 'dart:convert';

class TriviaResponse {
  final int responseCode;
  final List<Question> results;

  TriviaResponse({required this.responseCode, required this.results});

  /// Parses the entire JSON map into a TriviaResponse object.
  factory TriviaResponse.fromJson(Map<String, dynamic> json) {
    // Parse the list of results by mapping each item to a Question object
    var resultsList = json['results'] as List;
    List<Question> questions = resultsList
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();

    return TriviaResponse(
      responseCode: json['response_code'],
      results: questions,
    );
  }
}

/// Represents a single trivia question.
class Question {
  final String type;
  final String difficulty;
  final String category;
  final String questionText;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> allOptions;

  Question({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.questionText,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.allOptions,
  });

  /// Parses a single question's JSON map into a Question object.
  factory Question.fromJson(Map<String, dynamic> json) {

    // 2. CREATE AN INSTANCE of the unescaper
    var unescape = HtmlUnescape();

    // 3. DECODE all the text fields
    String correct = unescape.convert(json['correct_answer']);
    String question = unescape.convert(json['question']);
    List<String> incorrect = (json['incorrect_answers'] as List)
        .map((answer) => unescape.convert(answer as String))
        .toList();

    // 4. Combine the *decoded* lists
    List<String> options = [correct, ...incorrect];
    options.shuffle();

    return Question(
      type: json['type'],
      difficulty: json['difficulty'],
      category: json['category'],
      questionText: question, // Use the decoded question
      correctAnswer: correct,
      incorrectAnswers: incorrect,
      allOptions: options,
    );
  }
}