import 'dart:async';
import 'package:flutter/material.dart';

class PulsingOutlineButton extends StatefulWidget {
  final VoidCallback onpressed;
  final Widget child;
  const PulsingOutlineButton({
    Key? key,
    required this.onpressed,
    required this.child,
  }) : super(key: key);

  @override
  _PulsingOutlineButtonState createState() => _PulsingOutlineButtonState();
}

class _PulsingOutlineButtonState extends State<PulsingOutlineButton> {
  // The color of the animated outline
  final Color _animationColor = Colors.blue;

  // We'll toggle this bool to trigger the animation
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Start a timer to toggle the animation state every second
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        // Check if the widget is still in the tree
        setState(() {
          _isAnimating = !_isAnimating;
        });
      } else {
        timer.cancel(); // Cancel timer if widget is disposed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1), // Animation duration
      curve: Curves.easeInOut, // Animation curve
      decoration: BoxDecoration(
        border: Border.all(
          // Animate the color
          color: _isAnimating
              ? _animationColor.withOpacity(1.0)
              : _animationColor.withOpacity(0.3),
          // Animate the width
          width: _isAnimating ? 3.0 : 2.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: OutlinedButton(
        onPressed: widget.onpressed,
        style: OutlinedButton.styleFrom(
          // Make the button's own border transparent
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ), // Must be slightly less than container
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
