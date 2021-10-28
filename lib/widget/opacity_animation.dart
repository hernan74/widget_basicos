import 'package:flutter/material.dart';

///Widget para animar el cambio de opacidad
class OpacityAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const OpacityAnimation(
      {Key? key,
      required this.child,
      this.duration = Duration.zero,
      this.delay = Duration.zero})
      : super(key: key);

  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacidad;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    opacidad = Tween(begin: 0.0, end: 1.0).animate(controller);
    _animar();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _animar() async {
    await Future.delayed(widget.delay);
    if (mounted) controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Opacity(opacity: opacidad.value, child: widget.child);
        });
  }
}
