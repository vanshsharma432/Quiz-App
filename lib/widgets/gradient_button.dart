import 'package:flutter/material.dart';
import 'package:quiz_app/app_pallete.dart';
import 'package:quiz_app/appfonts.dart';
import 'package:quiz_app/loading.dart';

class GradientButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onPressed;
  final Map? dimensions;
  final IconData? icon;
  const GradientButton({super.key, required this.buttontext, required this.onPressed, this.dimensions, this.icon});

  @override
  Widget build(BuildContext context) {
    final double width = (dimensions?['width'] != null) ? dimensions!['width'] as double : 200.0;
    final double height = (dimensions?['height'] != null) ? dimensions!['height'] as double : 36.0;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [AppPallete.gradient, AppPallete.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(buttontext , style: Appfonts.medbodybold.copyWith(color: Colors.white) ),
                if (icon != null) ...[
                  SizedBox(width: 8.0),
                  Icon(icon, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
