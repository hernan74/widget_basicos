import 'package:flutter/material.dart';

///Widget de complemento para el carrusel para marcar la pagina actual con un circulo en la parte inferiro
class MarcaPaginaActual extends StatelessWidget {
  final double anchoMaximo;
  final double altoMaximo;
  final int cantItems;
  final int paginaActual;

  const MarcaPaginaActual(
      {Key? key,
      required this.anchoMaximo,
      required this.altoMaximo,
      required this.cantItems,
      required this.paginaActual})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: altoMaximo * 0.15,
        width: cantItems * (anchoMaximo * 0.06),
        alignment: Alignment.center,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cantItems,
            itemBuilder: (context, index) => AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: (paginaActual == index)
                    ? anchoMaximo * 0.06
                    : anchoMaximo * 0.04,
                margin: EdgeInsets.symmetric(vertical: altoMaximo * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: (paginaActual == index)
                        ? Colors.blueAccent.withOpacity(0.9)
                        : Colors.grey.withOpacity(0.5))),
            separatorBuilder: (context, index) =>
                SizedBox(width: anchoMaximo * 0.01)));
  }
}
