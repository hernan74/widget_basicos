import 'package:flutter/material.dart';

///Widget para armar una grilla auto ajustable
class GridViewWidget extends StatelessWidget {
  final List<Widget> listaElementos;
  final double maxWidth;
  final double widthItem;
  final double maxHeightItem;
  final Axis scrollDirection;

  const GridViewWidget({
    Key? key,
    required this.listaElementos,
    required this.maxWidth,
    required this.widthItem,
    this.maxHeightItem = 120.0,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: scrollDirection,
      physics: const BouncingScrollPhysics(),
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (maxWidth ~/ (widthItem + 12) == 0)
              ? 1
              : maxWidth ~/ (widthItem + 12),
          mainAxisExtent: maxHeightItem),
      itemBuilder: (_, index) => listaElementos[index],
      itemCount: listaElementos.length,
    );
  }
}
