import 'package:flutter/material.dart';
import 'package:widget_basicos/widget/stepper_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (paginaActual == 0) {
              return true;
            } else {
              setState(() {
                paginaActual--;
              });
              return false;
            }
          },
          child: StepperWidget(
            steeps: [
              SteepModel(
                  indice: 0, icono: Icons.ac_unit_outlined, titulo: 'Steep 1'),
              SteepModel(
                  indice: 1, icono: Icons.ac_unit_outlined, titulo: 'Steep 2'),
              SteepModel(
                  indice: 2, icono: Icons.ac_unit_outlined, titulo: 'Steep 3'),
              SteepModel(
                  indice: 3, icono: Icons.ac_unit_outlined, titulo: 'Steep 4'),
              SteepModel(
                  indice: 4, icono: Icons.ac_unit_outlined, titulo: 'Steep 5'),
              SteepModel(
                  indice: 5, icono: Icons.ac_unit_outlined, titulo: 'Steep 6'),
            ],
            titulo: 'Un titulo',
            steepsView: [
              Container(color: Colors.red),
              Container(color: Colors.blue),
              Container(color: Colors.green),
              Container(color: Colors.yellow),
              Container(color: Colors.brown),
              Container(color: Colors.orange),
            ],
            altoMaximo: 500,
            steepButton: [
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 1'),
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 2'),
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 3'),
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 4'),
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 5'),
              SteepButton(icono: Icons.chevron_right, titulo: 'titulo 6'),
            ],
            pageChanged: () {
              ///Para que no siga cargango valores
              if (paginaActual > 4) {
                return;
              }
              paginaActual++;
              setState(() {});
              print('Cambio pagina Se puede realizar acciones aca');
            },
            tamanofuenteTitulo: 10,
            paginaActual: paginaActual,
          ),
        ),
      ),
    );
  }
}
