import 'dart:async';

import 'package:flutter/material.dart';

class FadeButtonAuto extends StatefulWidget {
  final Widget child;

  const FadeButtonAuto({Key? key, required this.child}) : super(key: key);

  @override
  FadeButtonAutoState createState() => FadeButtonAutoState();
}

class FadeButtonAutoState extends State<FadeButtonAuto>
    with SingleTickerProviderStateMixin {
  late Animation _animationFadeInOut;
  late AnimationController _animationController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationFadeInOut = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  void animationRun() {
    _animationController.reverse().then((value) {
      if (_timer != null) {
        _timer!.cancel();
      }
      if (mounted) {
        _timer = Timer(const Duration(seconds: 5), () {
          if (mounted) {
            _animationController.forward();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animationFadeInOut.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
