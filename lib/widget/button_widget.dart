import 'package:flutter/material.dart';

///Un widget de boton
class ButtonWidget extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final IconData? icono;
  final double? iconoSize;
  final bool botonLadoDerecho;
  final EdgeInsetsGeometry padding;
  final double? altoMaximo;
  final double? anchoMaximo;
  const ButtonWidget(
      {Key? key,
      required this.texto,
      this.onPressed,
      this.icono,
      this.botonLadoDerecho = false,
      EdgeInsetsGeometry? padding,
      this.iconoSize,
      this.altoMaximo,
      this.anchoMaximo})
      : padding = padding ?? const EdgeInsets.symmetric(horizontal: 45),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: anchoMaximo,
        height: altoMaximo,
        child: RawMaterialButton(
            splashColor: Colors.blueAccent,
            padding: padding,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ///Agrega el icono si no es null y si [botonLadoIzquierdo] es true
              if (icono != null && !botonLadoDerecho) ...[
                Icon(
                  icono,
                  color: onPressed != null ? Colors.blue : Colors.grey,
                  size: iconoSize,
                ),
                SizedBox(width: icono != null ? size.width * 0.01 : 0)
              ],
              Text(
                texto,
                style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: onPressed != null ? Colors.blue : Colors.grey),
              ),

              ///Agrega el icono si no es null y si [botonLadoIzquierdo] es false
              if (icono != null && botonLadoDerecho) ...[
                SizedBox(
                  width: icono != null ? size.width * 0.01 : 0,
                ),
                Icon(icono,
                    color: onPressed != null ? Colors.blue : Colors.grey,
                    size: iconoSize)
              ]
            ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                    color: onPressed != null
                        ? Colors.blueAccent.withOpacity(0.5)
                        : Colors.grey)),
            onPressed: onPressed));
  }
}
