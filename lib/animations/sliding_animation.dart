import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          
          // Control the speed of the animation
          transitionDuration: const Duration(milliseconds: 300), 
          
          // Define the animation itself
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            
            // Start position (from the right)
            const begin = Offset(1.0, 0.0);
            
            // End position (at its final spot)
            const end = Offset.zero;
            
            // Add an easing curve for a nice effect
            final curve = Curves.ease;
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            // Create the Tween (from begin to end)
            final tween = Tween(begin: begin, end: end);

            // Return the animated widget
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
}