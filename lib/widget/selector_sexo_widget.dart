import 'package:flutter/material.dart';

///Widget para la seleccion de sexo
class SelectorSexoWidget extends StatefulWidget {
  final double anchoMaximo;
  final double altoMaximo;
  final ValueChanged<Sexo> onChanged;
  final String? sexoDefecto;

  const SelectorSexoWidget(
      {Key? key,
      required this.anchoMaximo,
      required this.altoMaximo,
      required this.onChanged,
      this.sexoDefecto})
      : super(key: key);
  @override
  _SelectorSexoWidgetState createState() => _SelectorSexoWidgetState();
}

class _SelectorSexoWidgetState extends State<SelectorSexoWidget> {
  Sexo? sexo;

  @override
  void initState() {
    if (widget.sexoDefecto != null && widget.sexoDefecto!.isNotEmpty) {
      sexo = SexoExtension.getSexoValor(widget.sexoDefecto);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.anchoMaximo,
      height: widget.altoMaximo,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _crearItem(
            Sexo.m, Icons.male, sexo == Sexo.m, widget.anchoMaximo * 30 / 100),
        _crearItem(Sexo.f, Icons.female, sexo == Sexo.f,
            widget.anchoMaximo * 30 / 100),
        _crearItem(Sexo.o, Icons.transgender, sexo == Sexo.o,
            widget.anchoMaximo * 30 / 100)
      ]),
    );
  }

  Widget _crearItem(
      Sexo sexo, IconData icono, bool seleccionado, double anchoItem) {
    return InkWell(
      onTap: () {
        setState(() {
          this.sexo = sexo;
          widget.onChanged.call(sexo);
        });
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.altoMaximo,
          width: anchoItem,
          padding: EdgeInsets.only(left: widget.anchoMaximo * 1 / 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: seleccionado ? Colors.blueAccent : Colors.transparent,
              border: Border.all(width: 1, color: Colors.blueAccent)),
          child: Row(
            children: <Widget>[
              Icon(icono,
                  color: seleccionado
                      ? Theme.of(context).primaryColor
                      : Colors.blueAccent,
                  size: widget.altoMaximo * 50 / 100),
              SizedBox(width: widget.anchoMaximo * 1 / 100),
              Text(sexo.name,
                  style: TextStyle(
                      fontSize: widget.altoMaximo * 30 / 100,
                      color: seleccionado
                          ? Theme.of(context).primaryColor
                          : Colors.blueAccent))
            ],
          )),
    );
  }
}

enum Sexo {
  m,
  f,
  o,
}

extension SexoExtension on Sexo {
  static const names = {
    Sexo.m: 'Masculino',
    Sexo.f: 'Femenino',
    Sexo.o: 'No Binario'
  };
  static const values = {Sexo.m: 'M', Sexo.f: 'F', Sexo.o: 'X'};

  String get name => names[this]!;
  String get value => values[this]!;

  static String getSexoNombre(String? sexo) {
    if (sexo == null || sexo.isEmpty) return '';
    return Sexo.values.firstWhere((s) => s.value == sexo).name;
  }

  static Sexo getSexoValor(String? sexo) =>
      Sexo.values.firstWhere((s) => s.value == sexo);
}
