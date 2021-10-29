import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widget_basicos/widget/button_widget.dart';
import 'package:widget_basicos/widget/marca_pagina_actual_widget.dart';

///[titulo] Titulo para el [StepperWidget]. NOTA debe existir el mismo numero de [steeps], [steepsView] y [steepButton]
///[steeps] Listado de [SteepModel] para armar los widget de steep que se encuentran debajo del titulo
///[steepsView] Widgets que se mostraran de acuerdo al steep actual
///[steepButton] Items de tipo [SteepButton] para cambiar el icono y titulo del boton de la parte inferior que cambia de vista del Steeper
class StepperWidget extends StatefulWidget {
  final bool ocultarTitulo;
  final String titulo;
  final List<SteepModel> steeps;
  final List<Widget> steepsView;
  final List<SteepButton> steepButton;
  final double altoMaximo;
  final double tamanofuenteTitulo;
  final int paginaActual;

  final VoidCallback pageChanged;

  const StepperWidget(
      {Key? key,
      required this.steeps,
      required this.titulo,
      required this.steepsView,
      required this.altoMaximo,
      required this.steepButton,
      required this.pageChanged,
      required this.tamanofuenteTitulo,
      required this.paginaActual,
      this.ocultarTitulo = false})
      : assert(steeps.length == steepsView.length),
        assert(steeps.length == steepButton.length),
        assert(steepButton.length == steepsView.length),
        super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  ///Es una bandera para poder cambiar la duracion de la animacion de los widget de [_FormularioDatosPersonales]
  ///Al abrir la ventana el valor es true y hace que la animacion dure mas  para esperar la animacion de carga de la view
  ///Al cambiar entre el pageView se vuelve false para que realize la animacion mas rapido
  bool primeraCarga = true;

  ///Pagina actual.
  ///[pagina] =Pagina 0.  Datos Personales
  ///[pagina] =Pagina 1.  Datos login
  int paginaActual = 0;

  ///Todo el controller debera implementarse posiblemente donde se utilice cuando este el bloc
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (paginaActual != widget.paginaActual) {
      setState(() {
        _cambiarPagina(widget.paginaActual);
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ///Cabecera
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 5 / 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.ocultarTitulo)
                Hero(
                  tag: 'titulo',
                  child: Container(
                    width: size.width,
                    height: size.height * 8 / 100,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: <Widget>[
                        ///Titulo
                        Text(widget.titulo,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: widget.tamanofuenteTitulo)),
                      ],
                    ),
                  ),
                ),

              ///Contenido

              SizedBox(
                height: widget.altoMaximo,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: widget.steepsView,
                ),
              ),
              _botonSigienteConfirmar(size)
            ],
          ),
        ),
      ],
    );
  }

  ///Cambia entre la pagina del formulario de registro
  void _cambiarPagina(int pagina) {
    primeraCarga = false;
    if ((widget.steeps.length) <= pagina) return;
    paginaActual = pagina;
    pageController.animateToPage(pagina,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  ///Boton de la parte inferior para cambiar de steep
  Widget _botonSigienteConfirmar(Size size) {
    return Row(
      children: [
        MarcaPaginaActual(
            anchoMaximo: size.width * 0.9,
            altoMaximo: size.height * 0.12,
            cantItems: widget.steeps.length,
            paginaActual: paginaActual),
        Hero(
          tag: 'BotonIngresarContinuar',
          child: Container(
            height: size.height * 4.5 / 100,
            margin: EdgeInsets.only(right: size.width * 5 / 100),
            width: size.width * 45 / 100,
            child: ButtonWidget(
              botonLadoDerecho: true,
              texto: widget.steepButton[paginaActual].titulo,
              icono: widget.steepButton[paginaActual].icono,
              iconoSize: size.height * 2.5 / 100,
              padding: EdgeInsets.symmetric(horizontal: size.width * 4 / 100),
              onPressed: () {
                setState(() {
                  widget.pageChanged.call();
                  _cambiarPagina(widget.paginaActual);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

///[SteepModel] Modelo para el item del paso actual que se muestra en la parte superior.
///[indice] Indice del item. NOTA el indice debe comenzar en 1.
///[icono] Icono para el item del steep.
///[titulo] Titulo para el item del steep.
class SteepModel {
  int indice;
  IconData icono;
  String titulo;

  SteepModel({required this.indice, required this.icono, required this.titulo});
}

///[SteepButton] Boton que se muestra en la parte inferior que es el encargado de cambiar de vista del [StepperWidget].
///[icono] Icono para el boton.
///[Titulo] Titulo del boton.
///[onPressed] Accion a realizar al hacer click en el boton
class SteepButton {
  IconData icono;
  String titulo;

  SteepButton({required this.icono, required this.titulo});
}

///Widget que se muestra debajo del titulo indicando el paso actual del Steeper.
///[pagina] Indice del Steep.
///[Modelo] item del tipo [SteepModel].
///[completo] Indica si el steep ya se completo para marcarlo.
///[paginaActual] Pagina actual que se encuentra el [StepperWidget]
class Steep extends StatelessWidget {
  final int pagina;
  final SteepModel modelo;
  final bool completo;
  final int paginaActual;

  const Steep(
      {Key? key,
      required this.pagina,
      required this.completo,
      required this.paginaActual,
      required this.modelo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final estiloSeleccionado =
        TextStyle(color: Colors.blueAccent, fontSize: size.height * 2.0 / 100);
    final estiloSinSeleccionar = TextStyle(
        color: completo ? Colors.green : Colors.grey,
        fontSize: size.height * 1.5 / 100);
    final bool paginaSeleccionada = (pagina - 1) == paginaActual;
    return Row(children: <Widget>[
      Container(
        child: Icon(
          completo ? FontAwesomeIcons.check : modelo.icono,
          color: paginaSeleccionada
              ? Colors.blueAccent
              : completo
                  ? Colors.green
                  : Colors.grey,
          size: paginaSeleccionada
              ? size.height * 2.0 / 100
              : size.height * 1.5 / 100,
        ),
        width:
            paginaSeleccionada ? size.height * 4 / 100 : size.height * 3 / 100,
        height: size.height * 4 / 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: paginaSeleccionada
                    ? Colors.blueAccent
                    : completo
                        ? Colors.green
                        : Colors.grey),
            shape: BoxShape.circle),
      ),
      SizedBox(width: size.width * 1 / 100),
      Text(modelo.titulo,
          style: paginaSeleccionada ? estiloSeleccionado : estiloSinSeleccionar)
    ]);
  }
}
