import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModel {
  Image nuevaImagen;
  String path;

  ImagePickerModel({required this.nuevaImagen, required this.path});
}

/// un metodo para la seleccion de una imagen pide un origen para la seleccion
/// Estos pueden ser una camara o galeria
Future<ImagePickerModel?> imagePickerFutureWidget(ImageSource origin) async {
  final _picker = ImagePicker();

  final pickedFile = await _picker.pickImage(
      source: origin, imageQuality: 30, maxWidth: 1920, maxHeight: 1080);
  if (pickedFile == null) {
    return null;
  }
  late ImagePickerModel nuevaImagen;
  nuevaImagen = ImagePickerModel(
      nuevaImagen: imageFromPathUtil(pickedFile.path), path: pickedFile.path);

  return nuevaImagen;
}

Image imageFromPathUtil(String path) {
  Image image;
  if (path == 'NOK') {
    return Image.asset(
      'assets/images/avatar.png',
      fit: BoxFit.cover,
    );
  }
  if (kIsWeb) {
    image = Image.network(
      path,
      fit: BoxFit.cover,
    );
    return image;
  } else {
    File file = File(path);
    image = Image.file(file, fit: BoxFit.cover);
    return image;
  }
}
