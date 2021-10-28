import 'package:flutter/material.dart';

///Widget para expandir y contraer un texto
class TextExpandWidget extends StatefulWidget {
  final String text;
  final double anchoMaximo;
  final double altoMaximo;
  final EdgeInsets padding;
  final TextStyle? estiloTexto;
  final Color? colorFuenteLetra;
  final bool expandirTexto;
  final TextAlign alineacionTexto;

  const TextExpandWidget(
      {Key? key,
      required this.text,
      required this.anchoMaximo,
      this.colorFuenteLetra,
      required this.altoMaximo,
      this.padding = const EdgeInsets.only(left: 14, right: 10),
      this.estiloTexto,
      this.expandirTexto = false,
      this.alineacionTexto = TextAlign.center})
      : super(key: key);

  @override
  _TextExpandWidgetState createState() => _TextExpandWidgetState();
}

class _TextExpandWidgetState extends State<TextExpandWidget> {
  bool textoExpandido = false;

  @override
  void initState() {
    super.initState();
    textoExpandido = widget.expandirTexto;
  }

  @override
  Widget build(BuildContext context) {
    ///[estiloTexto] Estilo que poseera la descripcion del item
    final estiloTexto = widget.estiloTexto ??
        TextStyle(
            fontSize: widget.altoMaximo * 50 / 100,
            fontWeight: FontWeight.bold,
            color: widget.colorFuenteLetra);

    return GestureDetector(
      onTap: () => setState(() => textoExpandido = !textoExpandido),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.anchoMaximo,
        padding: widget.padding,
        child: Text(widget.text,
            overflow:
                textoExpandido ? TextOverflow.visible : TextOverflow.ellipsis,
            textAlign: widget.alineacionTexto,
            style: estiloTexto),
      ),
    );
  }
}
