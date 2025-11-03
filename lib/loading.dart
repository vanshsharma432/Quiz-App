import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'models.dart'; // Make sure this file exists
import 'screens/quiz_screen.dart'; // We will create this new file
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true; // Start in loading state
  String? _error; // To store any potential error message

  @override
  void initState() {
    super.initState();
    // Start loading the data as soon as the widget is initialized
    _loadQuizData();
  }

  /// Fetches and parses trivia questions.
  /// This function now *only* handles fetching and throws an error on failure.
  Future<List<Question>> fetchTriviaQuestions() async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=10&type=multiple',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final TriviaResponse triviaResponse = TriviaResponse.fromJson(jsonData);
        return triviaResponse.results;
      } else {
        // API error
        throw Exception(
          'Failed to load trivia. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Network or other errors
      throw Exception('Failed to fetch trivia: $e');
    }
  }

  /// Coordinates loading, navigation, and error handling.
  void _loadQuizData() async {
    // Ensure we are showing the loading state and clear old errors
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Await the future to get the list of questions
      final List<Question> questions = await fetchTriviaQuestions();

      // IMPORTANT: Check if the widget is still mounted (i.e., user hasn't
      // navigated away) before trying to update state or navigate.
      if (!mounted) return;

      // Navigate to the QuizScreen, replacing the loading screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: questions, number: 0, score: 0,),
        ),
      );
    } catch (e) {
      // If an error occurred, update the state to show the error message
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
      print("\n❌ Error fetching trivia:\n$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: _buildBody()),
      ),
    );
  }

  /// Decides what to show in the center: Loader, Error, or nothing.
  Widget _buildBody() {
    if (_isLoading) {
      // Show loader while fetching
      return lottie.Lottie.asset(
        'assets/animations/Gears Lottie Animation.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    } else if (_error != null) {
      // Show error and a retry button
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadQuizData, // Call the load function again
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      // This case should rarely be seen, as success leads to navigation
      return Container();
    }
  }
}
