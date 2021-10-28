import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///Pueden modificar el tipo de dato del combo por una clase si se requiere
///para el modelo utiliza unicamnete un String
class ComboWidget extends StatefulWidget {
  final bool errorValidacion;
  final String titulo;
  final List<String> opciones;
  final String? valorDefecto;
  final ValueChanged<String> onSeleccionoOpcion;

  const ComboWidget(
      {Key? key,
      required this.opciones,
      required this.titulo,
      this.valorDefecto,
      required this.onSeleccionoOpcion,
      this.errorValidacion = false})
      : super(key: key);

  @override
  _ComboWidgetState createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  late String? valorSeleccionado;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    valorSeleccionado = widget.valorDefecto;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.75 / 100),
      height: size.height * 6 / 100,
      child: Stack(
        children: [
          if (widget.errorValidacion)
            Positioned(
              right: size.width * 0.5 / 100,
              child: _IconoValidacion(altoCampo: size.height * 6 / 100),
            ),
          DropdownButtonFormField<String>(
            icon: Icon(
              FontAwesomeIcons.caretDown,
              size: size.height * 2.7 / 100,
              color: widget.opciones.isNotEmpty
                  ? !widget.errorValidacion
                      ? Theme.of(context).primaryColor
                      : Colors.red
                  : Colors.grey,
            ),
            decoration: InputDecoration(
              labelText: widget.titulo,
              labelStyle: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: size.height * 2 / 100),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 2 / 100,
                  vertical: size.height * 1 / 100),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.opciones.isNotEmpty
                        ? !widget.errorValidacion
                            ? Theme.of(context).primaryColor
                            : Colors.red
                        : Colors.grey),
              ),
            ),
            value: valorSeleccionado,
            onChanged: (value) {
              setState(() {
                valorSeleccionado = value!;
                widget.onSeleccionoOpcion.call(value);
              });
            },
            items: widget.opciones
                .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}

class _IconoValidacion extends StatelessWidget {
  final double altoCampo;
  const _IconoValidacion({required this.altoCampo});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cancel_outlined,
      size: altoCampo * 33 / 100,
      color: const Color(0xffD94D4D),
    );
  }
}
