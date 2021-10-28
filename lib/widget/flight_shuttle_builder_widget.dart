import 'package:flutter/material.dart';

// Es utilizado para envolver un widget a la hora de hacer una transicion a otra ventana y posea un MaterialStyle
// Ejemplo al hacer la transicion de una ventana a otra de un widget de 'TEXT' que flutter no ponga el subrayado amarillo al texto

class FlightShuttleBuilderWidget extends StatelessWidget {
  final BuildContext flightContext;
  final Animation<double> animation;
  final HeroFlightDirection flightDirection;
  final BuildContext fromHeroContext;
  final BuildContext toHeroContext;

  const FlightShuttleBuilderWidget(this.flightContext, this.animation,
      this.flightDirection, this.fromHeroContext, this.toHeroContext,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: SingleChildScrollView(child: toHeroContext.widget),
    );
  }
}
