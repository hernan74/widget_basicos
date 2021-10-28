import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widget_basicos/global/environment.dart';

class Utilidades {
  //Aca devuelvo el path completo de la Carpeta que deceo acceder sino esta no
  //existe la creo
  static Future<String> creaCarpetaInAppDocDir(String folderName) async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');
    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  static Future<bool> existeAchivo(String fullpath) async {
    if (fullpath.isEmpty || fullpath == 'NOK') {
      return false;
    }
    final file = File(fullpath);
    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  /// [colorFromString] Devuelve un color en base a un string con valores hexadecimales
  /// [color] si es null o en blanco devuelve color por defecto.
  static Color colorFromString(String color) {
    if (color.isEmpty) {
      return Colors.blueGrey;
    } else if (!color.contains('#', 0)) {
      return Colors.blueGrey;
    } else {
      return Color(int.tryParse(color.replaceAll('#', '0xff')) ?? 0);
    }
  }

  //Esta metodo es utilizado para mantener el tamaño de un widget en un rango de valores

  static double sizeScreemUtil(
      {required double sizeActual,
      required double sizeMin,
      required double sizeMax}) {
    if (sizeActual < sizeMax && sizeActual > sizeMin) return sizeActual;

    if (sizeActual < sizeMin) {
      return sizeMin;
    } else if (sizeActual > sizeMax) {
      return sizeMax;
    } else {
      return sizeActual;
    }
  }

  ///Medoto para cambiar el color de los widget en renovacion de token en base al estado de conexion
  static Color estadoConexion(int estado) {
    switch (estado) {
      case -1:
        return Colors.redAccent;
      case 0:
        return Colors.blueAccent;
      default:
        return Colors.green;
    }
  }

  static DateTime verificarFechaValida(String date, String formatoFecha) {
    if (date.isEmpty || DateTime.tryParse(date.replaceAll('/', '')) == null) {
      return DateTime.now();
    }

    DateTime fecha = DateFormat(formatoFecha).parse(date);

    return fecha;
    // if (fecha == null) {
    //   return DateTime.now();
    // } else {
    //   return fecha;
    // }
  }

  static String formatearFecha(String fechaInput) {
    if (fechaInput.isEmpty) {
      return '';
    } else if (fechaInput.length != 8) {
      return '';
    }
    return '${fechaInput.substring(0, 2)}/${fechaInput.substring(2, 4)}/${fechaInput.substring(4, 8)}';
  }

  static Widget determinarImagenHomeItemLista(String url, BoxFit fit) {
    return (url.isEmpty)
        ? Image.asset('assets/loading.gif', fit: BoxFit.cover)
        : (url == Environment.sinImagen)
            ? Image.asset('assets/no-image.png', fit: BoxFit.fill)
            : (url == Environment.imgSinDownLoad)
                ? Image.asset(
                    'assets/sin-descarga.jpg',
                    fit: fit,
                  )
                : Image.file(File(url), fit: fit);
  }
}
