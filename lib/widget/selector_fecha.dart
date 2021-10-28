import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widget_basicos/utils/utilidades.dart';
import 'package:widget_basicos/widget/textfield_widget.dart';

///Widget para la seleccion de fecha
class SelectorFechaWidget extends StatefulWidget {
  final String fechaInicial;
  final ValueChanged<String> onFechaSeleccionada;
  final String titulo;
  final double anchoMaximo;
  final bool errorValidacion;

  const SelectorFechaWidget(
      {Key? key,
      required this.onFechaSeleccionada,
      required this.fechaInicial,
      required this.titulo,
      required this.anchoMaximo,
      this.errorValidacion = false})
      : super(key: key);

  @override
  _SelectorFechaWidgetState createState() => _SelectorFechaWidgetState();
}

class _SelectorFechaWidgetState extends State<SelectorFechaWidget> {
  String fechaSeleccionada = '';
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    fechaSeleccionada = widget.fechaInicial;
    controller = TextEditingController(text: fechaSeleccionada);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (widget.fechaInicial != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = widget.fechaInicial;
        controller.text = fechaSeleccionada;
      });
    }
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: Colors.blueAccent, backgroundColor: Colors.white),
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () async {
            await _mostrarSelectorFecha(context, 'dd/MM/yyyy');
            widget.onFechaSeleccionada.call(fechaSeleccionada);
            controller.text = fechaSeleccionada;
          },
          child: AbsorbPointer(
            child: TextfieldWidget(
              iconoIzquierda: FontAwesomeIcons.calendarAlt,
              errorValidacion: widget.errorValidacion,
              altoCampo: size.height * 7 / 100,
              anchoCampo: widget.anchoMaximo,
              labelText: widget.titulo,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _mostrarSelectorFecha(
      BuildContext context, String formatoFecha) async {
    DateTime? fecha = await showDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (_) => DatePickerDialog(
        fieldHintText: 'dd/MM/yyyy',
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate:
            Utilidades.verificarFechaValida(fechaSeleccionada, formatoFecha),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ),
    );
    FocusScope.of(context).requestFocus(FocusNode());
    fechaSeleccionada = (fecha == null)
        ? fechaSeleccionada
        : DateFormat(formatoFecha).format(fecha);
  }
}
