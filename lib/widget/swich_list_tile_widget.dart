import 'package:flutter/material.dart';

class SwichListTile extends StatefulWidget {
  final String titulo;
  final String descripcion;
  final double ancho;
  final double alto;
  final Color checkColor;
  final Color fondoCheckColor;
  final bool initialValue;

  final double bordeRedondeado;
  final ValueChanged<bool>? onChanged;
  final IconData? icono;
  // final bool seleccion;
  const SwichListTile({
    Key? key,
    this.titulo = '',
    this.ancho = 100,
    this.alto = 60,
    this.checkColor = Colors.blueAccent,
    this.fondoCheckColor = Colors.blueAccent,
    this.bordeRedondeado = 50,
    this.onChanged,
    this.descripcion = 'descripcion',
    this.icono,
    this.initialValue = false,
    // this.seleccion,
  }) : super(key: key);

  @override
  _SwichListTileState createState() => _SwichListTileState();
}

class _SwichListTileState extends State<SwichListTile> {
  bool seleccionado = false;

  @override
  void initState() {
    seleccionado = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final estiloTitulo = Theme.of(context)
        .textTheme
        .headline5!
        .copyWith(fontSize: size.height * 1.7 / 100);
    final estiloSubTitulo = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: size.height * 1.7 / 100);
    return Row(
      children: [
        if (widget.icono != null)
          Container(
            padding: EdgeInsets.only(right: size.width * 4 / 100),
            child: Icon(
              widget.icono,
              size: size.height * 4 / 100,
            ),
          ),
        Expanded(
          child: SwitchListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.titulo, style: estiloTitulo),
                Text(widget.descripcion, style: estiloSubTitulo),
              ],
            ),
            onChanged: (value) => setState(() {
              seleccionado = value;
              widget.onChanged?.call(value);
            }),
            value: seleccionado,
            activeColor: widget.fondoCheckColor,
          ),
        ),
      ],
    );
  }
}
