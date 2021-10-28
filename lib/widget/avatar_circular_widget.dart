import 'package:flutter/material.dart';

///Avatar circular se puede utilizar para un perfil de usuario
class AvatarCircularWidget extends StatelessWidget {
  final double sizeMaximo;
  final Widget imagenWidget;

  const AvatarCircularWidget(
      {Key? key, required this.sizeMaximo, required this.imagenWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: sizeMaximo,
      height: sizeMaximo,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset:
                    Offset(-(size.width * 1 / 100), size.height * 0.7 / 100))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: imagenWidget,
      ),
    );
  }
}
