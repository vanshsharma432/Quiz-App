import 'package:flutter/material.dart';
import '../models.dart';
import '../appfonts.dart'; // Make sure this file exists
import 'results_screen.dart'; // Make sure this file exists
import '../animations/sliding_animation.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final int number;
  final int score; // You need to track the score

  const QuizScreen({
    super.key,
    required this.questions,
    required this.number,
    required this.score, // Add score to the constructor
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // --- STATE VARIABLES ---
  String? _selectedAnswer; // Stores the text of the user's selected answer
  bool _isAnswered = false; // Locks buttons after an answer is chosen
  late String _correctAnswer;
  late int _currentScore;

  @override
  void initState() {
    super.initState();
    // Initialize state when the widget is first built
    _correctAnswer = widget.questions[widget.number].correctAnswer;
    _currentScore = widget.score;
  }

  // --- LOGIC FUNCTIONS ---

  /// Handles the logic when a user taps an answer button
  void _handleAnswer(String selectedOption) {
    // Do nothing if the user has already answered this question
    if (_isAnswered) return;

    final bool isCorrect = (selectedOption == _correctAnswer);

    // Update the state
    setState(() {
      _selectedAnswer = selectedOption;
      _isAnswered = true;
      if (isCorrect) {
        _currentScore++; // Increment the score if correct
      }
    });
  }

  /// Returns the button color based on the answer state
  Color _getButtonColor(String option) {
    if (!_isAnswered) {
      // Default color when no answer is selected
      return Colors.white;
    }

    // If an answer is selected
    if (option == _correctAnswer) {
      // Always color the correct answer green
      return Colors.green;
    } else if (option == _selectedAnswer) {
      // If this is the selected answer AND it's wrong, color it red
      return Colors.red;
    }

    // Default color for other incorrect, non-selected options
    return Colors.white;
  }

  /// Returns the text/border color based on the answer state
  Color _getForegroundColor(String option) {
    if (!_isAnswered) {
      return Colors.black; // Default
    }

    if (option == _correctAnswer || option == _selectedAnswer) {
      return Colors.white; // White text for green/red buttons
    }

    return Colors.black; // Default for non-selected
  }

  /// Navigation logic for the "Previous" button
  void onPrevQuestion() {
    if (widget.number > 0) {
      Navigator.pushReplacement(
        context,
        SlideRightRoute(
          page: QuizScreen(
            questions: widget.questions,
            number: widget.number - 1,
            // Pass the original score this page started with
            score: widget.score,
          ),
        ),
      );
    }
  }

  /// Navigation logic for the "Next" button
  void onNextQuestion() {
    // Check if we are on the last question
    if (widget.number < widget.questions.length - 1) {
      // Go to the next question
      Navigator.pushReplacement(
        context,
        SlideRightRoute(
          page: QuizScreen(
            questions: widget.questions,
            number: widget.number + 1,
            // Pass the newly updated score
            score: _currentScore,
          ),
        ),
      );
    } else {
      // Go to the results screen
      Navigator.pushReplacement(
        context,
        SlideRightRoute(
          page: ResultsScreen(
            score: _currentScore,
            totalQuestions: widget.questions.length,
          ),
        ),
      );
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Question currentQuestion = widget.questions[widget.number];
    final List<String> options = currentQuestion.allOptions;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: width>600 && width>height ? width*0.3 : 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double childWidth = constraints.maxWidth;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${widget.number + 1} of ${widget.questions.length}",
                    textAlign: TextAlign.left,
                    style: Appfonts.medbodybold.copyWith(
                      fontSize: height * 0.025,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentQuestion.questionText,
                    textAlign: TextAlign.left,
                    style: Appfonts.medbody.copyWith(fontSize: height * 0.025),
                  ),
                  const SizedBox(height: 32),

                  // --- DYNAMICALLY GENERATED BUTTONS ---
                  ...List.generate(options.length, (index) {
                    String option = options[index];
                    String letter = String.fromCharCode(
                      65 + index,
                    ); // A, B, C, D
                    Color buttonColor = _getButtonColor(option);
                    Color foregroundColor = _getForegroundColor(option);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          elevation: 0,
                          minimumSize: Size(childWidth, height * 0.07),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: buttonColor == Colors.white
                                  ? Colors.black
                                  : Colors.transparent,
                              width: height * 0.001,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        // Disable button by setting onPressed to null if answered
                        onPressed: () => _handleAnswer(option),
                        child: Text(
                          "$letter.  $option",
                          textAlign: TextAlign.left,
                          style: Appfonts.medbody.copyWith(
                            fontSize: height * 0.022,
                            color: foregroundColor,
                          ),
                        ),
                      ),
                    );
                  }),

                  // -------------------------------------
                  const Spacer(),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: onPrevQuestion,
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(width>600 && width>height? 150:width * 0.33, height * 0.06),
                          side: BorderSide(
                            color: Colors.black,
                            width: height * 0.001,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Previous",
                          style: Appfonts.smallbodybold.copyWith(
                            color: Colors.black,
                            fontSize: height * 0.022,
                          ),
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        // Only enable "Next" after an answer is selected
                        onPressed: _isAnswered ? onNextQuestion : null,
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(width>600? 150:width * 0.3, height * 0.06),
                          backgroundColor: _isAnswered
                              ? Colors.blueAccent
                              : Colors.grey,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Next",
                          style: Appfonts.smallbodybold.copyWith(
                            color: Colors.white,
                            fontSize: height * 0.022,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
