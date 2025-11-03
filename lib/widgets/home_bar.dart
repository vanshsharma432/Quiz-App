import 'package:flutter/material.dart';
import 'package:quiz_app/animations/hovering_image.dart';
import 'package:quiz_app/app_pallete.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: kToolbarHeight + height * 0.3 < 300
          ? 300
          : kToolbarHeight + height * 0.3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppPallete.gradient, AppPallete.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight + 8),
          Text(
            "Welcome to",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
              fontFamily: "Nunito",
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: HoveringImage(
              hoverHeight: 20,
              duration: Duration(seconds: 3),
              child: Image.asset(
                'assets/images/quiz_icon.png',
                height: height * 0.15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
