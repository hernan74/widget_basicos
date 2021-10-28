import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextfieldWidget extends StatefulWidget {
  final String? hintText;
  final String labelText;
  final double altoCampo;
  final double anchoCampo;
  final TextInputType textInputType;
  final int? maxLength;
  final IconData? iconoIzquierda;
  final IconData? iconoDerecha;
  final bool ocultarTexto;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool errorValidacion;
  final FocusNode? fNode;
  final TextEditingController? controller;

  const TextfieldWidget(
      {Key? key,
      this.hintText,
      required this.labelText,
      required this.altoCampo,
      required this.anchoCampo,
      this.textInputType = TextInputType.number,
      this.maxLength,
      this.iconoIzquierda,
      this.iconoDerecha,
      this.ocultarTexto = false,
      this.inputFormatters,
      this.controller,
      this.onChanged,
      this.errorValidacion = false,
      this.fNode})
      : super(key: key);

  @override
  _TextfieldWidgetState createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  bool ocultarTexto = true;

  @override
  void initState() {
    super.initState();
    ocultarTexto = widget.ocultarTexto;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: widget.anchoCampo,
      constraints: BoxConstraints(
          maxHeight: widget.altoCampo, minHeight: widget.altoCampo),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          if (widget.errorValidacion)
            Positioned(
              top: widget.altoCampo * 3 / 100,
              right: widget.anchoCampo * 0.5 / 100,
              child: _IconoValidacion(altoCampo: widget.altoCampo),
            ),
          Theme(
            child: TextField(
              controller: widget.controller,
              obscureText: ocultarTexto,
              keyboardType: widget.textInputType,
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged?.call,
              style: TextStyle(fontSize: widget.altoCampo * 30 / 100),
              focusNode: widget.fNode,
              decoration: _buildInputDecoration(size),
            ),
            data: Theme.of(context).copyWith(
              primaryColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(Size size) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: _determinarColor(widget.errorValidacion))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _determinarColor(widget.errorValidacion), width: 2)),
        hintText: widget.hintText,
        labelText: widget.labelText,

        ///Icono de la derecha es utilizado para mostrer u ocultar si es una contraseña
        suffixIcon: widget.ocultarTexto
            ? InkWell(
                onTap: () =>

                    ///Alterna entre ocultar y mostrar el texto
                    setState(() => ocultarTexto = !ocultarTexto),
                child: Icon(
                    (ocultarTexto)
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: _determinarColor(widget.errorValidacion),
                    size: widget.altoCampo * 40 / 100))
            : null,
        prefixIcon: widget.iconoIzquierda != null
            ? Icon(widget.iconoIzquierda,
                color: _determinarColor(widget.errorValidacion),
                size: widget.altoCampo * 40 / 100)
            : null,
        labelStyle: TextStyle(
            color: _determinarColor(widget.errorValidacion),
            fontSize: widget.altoCampo * 30 / 100),
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        errorStyle: const TextStyle(fontSize: 0),

        ///Quita el contador de caracteres faltantes para el [maxLength]
        counterText: "");
  }

  Color _determinarColor(bool errorValidacion) {
    return errorValidacion ? const Color(0xffD94D4D) : const Color(0xff4081EC);
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
