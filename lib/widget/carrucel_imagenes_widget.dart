import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget_basicos/widget/marca_pagina_actual_widget.dart';

///Widget de carrusel de imagenes no posee animacion de movimiento pero si una animacion para cambiar a pantalla completa
class CarrucelImagenesWidget extends StatefulWidget {
  final List<String> urlImagenes;
  final double anchoMaximo;
  final double altoMaximo;
  final ValueChanged<bool> isPantallaCompleta;
  const CarrucelImagenesWidget(
      {Key? key,
      required this.urlImagenes,
      required this.anchoMaximo,
      required this.altoMaximo,
      required this.isPantallaCompleta})
      : super(key: key);

  @override
  _CarrucelImagenesWidgetState createState() => _CarrucelImagenesWidgetState();
}

class _CarrucelImagenesWidgetState extends State<CarrucelImagenesWidget> {
  late StreamController<int> paginaStream;
  int paginaActual = 0;
  bool pantallaCompleta = false;
  @override
  void initState() {
    super.initState();
    paginaStream = StreamController.broadcast();
    paginaStream.stream.listen((int data) {
      setState(() {
        paginaActual = data;
      });
    });
  }

  @override
  void dispose() {
    paginaStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.anchoMaximo,
        child: Material(
          child: InkWell(
            onTap: () async {
              pantallaCompleta = true;
              widget.isPantallaCompleta.call(pantallaCompleta);
              await Navigator.of(context).push(_createRoute(
                  parentContext: context,
                  urlImagenes: widget.urlImagenes,
                  pagina: paginaActual,
                  paginaStream: paginaStream));

              pantallaCompleta = false;
              widget.isPantallaCompleta.call(pantallaCompleta);
            },
            child: _Carrucel(
                urlImagenes: widget.urlImagenes,
                altoMaximo: widget.altoMaximo,
                anchoMaximo: widget.anchoMaximo,
                paginaActual: paginaActual,
                paginaStream: paginaStream,
                pageController: PageController(initialPage: paginaActual),
                fit: BoxFit.cover),
          ),
        ));
  }
}

class _Carrucel extends StatelessWidget {
  final List<String> urlImagenes;
  final double altoMaximo;
  final double anchoMaximo;
  final int paginaActual;
  final StreamController<int> paginaStream;
  final BoxFit fit;
  final PageController pageController;

  const _Carrucel(
      {required this.urlImagenes,
      required this.altoMaximo,
      required this.anchoMaximo,
      required this.paginaActual,
      required this.paginaStream,
      required this.fit,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: paginaStream.sink.add,
        itemCount: urlImagenes.length,
        itemBuilder: (_, index) {
          final imagen = urlImagenes[index];
          return Image.file(File(imagen), fit: fit);
        },
      ),
      if (urlImagenes.length > 1)
        MarcaPaginaActual(
            altoMaximo: altoMaximo,
            anchoMaximo: anchoMaximo,
            cantItems: urlImagenes.length,
            paginaActual: paginaActual)
    ]);
  }
}

class _PantallaCompleta extends StatefulWidget {
  final StreamController<int> paginaStream;
  final List<String> urlImagenes;
  final int pagina;
  const _PantallaCompleta(
      {required this.pagina,
      required this.urlImagenes,
      required this.paginaStream});

  @override
  __PantallaCompletaState createState() => __PantallaCompletaState();
}

class __PantallaCompletaState extends State<_PantallaCompleta> {
  int paginaActual = 0;
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    paginaActual = widget.pagina;
    _controller = PageController(initialPage: widget.pagina);
    widget.paginaStream.stream.listen((int data) {
      if (mounted) {
        setState(() => paginaActual = data);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: _Carrucel(
                    pageController: _controller,
                    paginaStream: widget.paginaStream,
                    urlImagenes: widget.urlImagenes,
                    paginaActual: paginaActual,
                    anchoMaximo: size.width * 90 / 100,
                    altoMaximo: size.height * 10 / 100,
                    fit: BoxFit.contain,
                  ),
                ))));
  }
}

Route _createRoute(
    {required BuildContext parentContext,
    required List<String> urlImagenes,
    required StreamController<int> paginaStream,
    required int pagina}) {
  return PageRouteBuilder<void>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return _PantallaCompleta(
          paginaStream: paginaStream, pagina: pagina, urlImagenes: urlImagenes);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var rectAnimation = _createTween(parentContext)
          .chain(CurveTween(curve: Curves.ease))
          .animate(animation);

      return Stack(
        children: [
          PositionedTransition(rect: rectAnimation, child: child),
        ],
      );
    },
  );
}

Tween<RelativeRect> _createTween(BuildContext context) {
  var windowSize = MediaQuery.of(context).size;
  var box = context.findRenderObject() as RenderBox;
  var rect = box.localToGlobal(Offset.zero) & box.size;
  var relativeRect = RelativeRect.fromSize(rect, windowSize);

  return RelativeRectTween(
    begin: relativeRect,
    end: RelativeRect.fill,
  );
}
