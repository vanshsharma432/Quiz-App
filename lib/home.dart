import 'package:flutter/material.dart';
import 'package:quiz_app/appfonts.dart';
import 'package:quiz_app/loading.dart';
import 'package:quiz_app/widgets/gradient_button.dart';
import 'package:quiz_app/widgets/home_bar.dart';
import 'app_pallete.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        HomeBar(),
        Spacer(),
        Container(
          height: height * 0.5,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Started", style: Appfonts.subheading),
              SizedBox(height: height*0.01),
              Text(
                "Test your knowledge with our exciting quizzes! Challenge yourself and learn new things every day.",
                style: Appfonts.smallbodybold,
              ),
              SizedBox(height: height*0.04),
              Center(
                child: GradientButton(
                  buttontext: "Start Quiz",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loading()),
                    );
                  },
                  dimensions: {'width': width * 0.8},
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
