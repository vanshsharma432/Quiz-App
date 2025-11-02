import 'package:flutter/material.dart';

class HoveringImage extends StatefulWidget {
  /// The widget you want to animate
  final Widget child;
  
  /// The vertical distance the widget will travel
  final double hoverHeight;
  
  /// The duration of one full "up" and "down" cycle
  final Duration duration;

  const HoveringImage({
    super.key,
    required this.child,
    this.hoverHeight = 20, // Default 20 pixels
    this.duration = const Duration(milliseconds: 2500), // Default 2.5 seconds
  });

  @override
  State<HoveringImage> createState() => _HoveringImageState();
}

class _HoveringImageState extends State<HoveringImage>
    with SingleTickerProviderStateMixin { // Needed for the AnimationController
      
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // 2. Create the Tween (the range of values)
    // We go from 0 (original position) to -widget.hoverHeight (up)
    _animation = Tween<double>(begin: 0, end: -widget.hoverHeight).animate(
      // 3. Add a Curve for smooth easing
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // 4. Make the animation repeat forever
    _controller.repeat(reverse: true); // reverse: true makes it go up AND down
  }

  @override
  void dispose() {
    _controller.dispose(); // Always dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder is the most efficient way to do this.
    // It rebuilds *only* the Transform when the animation value changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Apply the vertical translation
        return Transform.translate(
          offset: Offset(0, _animation.value), // Use the animation's current value
          child: widget.child,
        );
      },
    );
  }
}