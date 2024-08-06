import 'package:flutter/material.dart';

class BkavBlinkingButton extends StatefulWidget {
  const BkavBlinkingButton({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  BkavBlinkingButtonState createState() => BkavBlinkingButtonState();
}

class BkavBlinkingButtonState extends State<BkavBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animationController, child: widget.child);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
