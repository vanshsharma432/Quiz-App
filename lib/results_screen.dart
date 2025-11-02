import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';
import 'appfonts.dart'; // Using your custom fonts
import 'loading.dart'; // To navigate back to the start

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  // Helper method to get a result message
  String getResultMessage() {
    double percentage = score / totalQuestions;
    if (percentage >= 0.9) {
      return 'Outstanding!';
    } else if (percentage >= 0.7) {
      return 'Great Job!';
    } else if (percentage >= 0.5) {
      return 'Well Done!';
    } else {
      return 'Better Luck Next Time!';
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // Use the same gradient as your other screens
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getResultMessage(),
                style: Appfonts.medbodybold.copyWith(
                  fontSize: height * 0.04,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'You Scored',
                style: Appfonts.medbody.copyWith(
                  fontSize: height * 0.025,
                  color: Colors.white,
                ),
              ),
              Text(
                '$score / $totalQuestions',
                style: Appfonts.medbodybold.copyWith(
                  fontSize: height * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                // This is the important part
                onPressed: () {
                  // Navigate back to the Loading screen to start a new quiz
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Loading()),
                  );
                },
                child: Text(
                  'Play Again',
                  style: Appfonts.medbodybold.copyWith(
                    fontSize: height * 0.022,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                // This is the important part
                onPressed: () {
                  // Navigate back to the Loading screen to start a new quiz
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Text(
                  'Home',
                  style: Appfonts.medbodybold.copyWith(
                    fontSize: height * 0.022,
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
