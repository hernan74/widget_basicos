import 'package:flutter/material.dart';

///Un widget que permite animar el cambio de tamaño
class CambioSizeAnimation extends StatefulWidget {
  final double sizeIniciar;
  final double sizeFinal;
  final Widget child;
  final Duration duracion;

  const CambioSizeAnimation(
      {Key? key,
      required this.sizeIniciar,
      required this.sizeFinal,
      required this.child,
      required this.duracion})
      : super(key: key);

  @override
  _CambioSizeAnimationState createState() => _CambioSizeAnimationState();
}

class _CambioSizeAnimationState extends State<CambioSizeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> size;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duracion);
    size = Tween(begin: widget.sizeIniciar, end: widget.sizeFinal)
        .animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width:
              (size.value == widget.sizeFinal) ? size.value : widget.sizeFinal,
          child: widget.child,
        );
      },
    );
  }
}
