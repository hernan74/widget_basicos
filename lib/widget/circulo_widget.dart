import 'package:flutter/material.dart';

class CirculoWidget extends StatelessWidget {
  final double sizeCirculo;
  final Color colorCiculo;
  final Widget contenidoCirculo;
  const CirculoWidget({
    Key? key,
    this.sizeCirculo = 50,
    this.colorCiculo = Colors.grey,
    required this.contenidoCirculo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeCirculo,
      height: sizeCirculo,
      decoration: BoxDecoration(color: colorCiculo, shape: BoxShape.circle),
      child: contenidoCirculo,
    );
  }
}
