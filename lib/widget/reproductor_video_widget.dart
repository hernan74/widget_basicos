import 'dart:io';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_basicos/global/environment.dart';
import 'package:widget_basicos/utils/utilidades.dart';
import 'package:widget_basicos/widget/circulo_widget.dart';

class ReproductorVideoWidget extends StatefulWidget {
  ///Especifica la fuente del archivo. [File], [assets], [network]
  final DataSourceType dataSourceType;

  ///Ruta del archivo
  final String url;

  ///True muestra opcion para acelerar el video
  final bool mostrarAcelerarVideo;

  ///Imagen para mostrar de pre visualizacion
  final String? imagenPlaceHolder;

  ///Accion a realizar al precionar play la primera vez cuaando este el [imagenPlaceHolder]
  final VoidCallback? onPressed;

  ///False si ya se termino de procesar la carga del video y esta listo para que lo cargue el reproductor
  final bool videoCargado;

  const ReproductorVideoWidget(
      {Key? key,
      required this.dataSourceType,
      required this.url,
      this.mostrarAcelerarVideo = true,
      this.imagenPlaceHolder,
      this.onPressed,
      this.videoCargado = false})
      : super(key: key);

  @override
  _ReproductorVideoWidgetState createState() => _ReproductorVideoWidgetState();
}

class _ReproductorVideoWidgetState extends State<ReproductorVideoWidget> {
  ///[_controller] Encargado de controlar el estado en el que se encuentra el video.
  late VideoPlayerController _controller;

  ///[_initializeVideoPlayerFuture] Future para saber cuando se termina de cargar el video para mostrar el [_reproductorVideo].
  late Future<void> _initializeVideoPlayerFuture;

  ///Es true cuando se realiza el click la primera vez y el usuario solicito cargar el video
  bool cargarVideo = false;

  ///Inizializa el video de acuerdo al [dataSourceType] seleccionado
  void _initializeVideoController() {
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _controller = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _controller = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.file:
        _controller = VideoPlayerController.file(File(widget.url));
        break;
      case DataSourceType.contentUri:

        ///No se utiliza esto
        _controller = VideoPlayerController.contentUri(Uri());
        break;
    }
    _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///Muestra el placeHolder. El video en este punto aun no se comenzo a cargar
    return !cargarVideo
        ? Container(
            width: widget.imagenPlaceHolder != null
                ? size.width * 0.4
                : size.width,
            height: size.height * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: (widget.imagenPlaceHolder != null)
                        ? widget.imagenPlaceHolder == Environment.imgSinDownLoad
                            ? const AssetImage('assets/no-image.png')
                            : FileImage(File(widget.imagenPlaceHolder!))
                                as ImageProvider
                        : const AssetImage('assets/carga_imagen.gif'),
                    fit: BoxFit.contain)),

            ///Boton de pley del placeHolder
            child: IconButton(
              icon: Icon(FontAwesomeIcons.playCircle,
                  color: Colors.blueGrey.withOpacity(0.7),
                  size: size.height * 10 / 100),

              ///Solicitar la carga del video por el usuario
              onPressed: () {
                cargarVideo = true;
                if (widget.onPressed != null) widget.onPressed;
                setState(() {});
              },
            ),
          )
        :

        ///Al dar play por primera vez cambia el placeHolder y espera a que [videoCargado] este en true (Video almacendo en el dispositivo).
        ///Cambia el widget de animacion de carga por el reproductor de video
        !(widget.videoCargado || cargarVideo)
            ? _loadingAnimacion(size)
            :

            ///Primer FutureBuilder verifica que la url proporcionada sea de un archivo existente en el dispositivo para evitar errores
            FutureBuilder(
                future: Utilidades.existeAchivo(widget.url),
                builder: (_, snapshot) {
                  ///True cuando se da pley al video
                  if (snapshot.hasData) {
                    ///Si el archivo existe en el dispositivo prosigue a inicializar el reproductor
                    if (snapshot.hasData ||

                        ///Si la fuente de video es [Asset] o [Network] ignora la validacion de [Utilidades.existeAchivo].
                        widget.dataSourceType != DataSourceType.file) {
                      ///Inicializacion del reproductor
                      if (cargarVideo) {
                        ///Ingresara si el video se termino de cargar y el controlador aun es null
                        if (!widget.videoCargado) {
                          _initializeVideoController();
                        }
                      }
                      return

                          ///Segundo Future builder para el proceso de carga del video en el reproductor
                          FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return _ReproductorVideo(
                                    controller: _controller,
                                    mostrarAcelerarVideo:
                                        widget.mostrarAcelerarVideo,
                                  );
                                } else {
                                  // If the VideoPlayerController is still initializing, show a
                                  // loading spinner.
                                  return _loadingAnimacion(size);
                                }
                              });
                    } else {
                      /// Si no se proporciono una url de video o no existe el video en el dispositivo muestra el msj en pantalla
                      return widget.url.isEmpty
                          ? _loadingAnimacion(size)
                          : const Center(
                              child: Text('No existe el archivo solicitado'));
                    }
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return _loadingAnimacion(size);
                  }
                },
              );
  }

  Widget _loadingAnimacion(Size size) {
    return SizedBox(
        height: size.height * 0.23,
        width: size.width,
        child: Image.asset('assets/carga_imagen.gif', fit: BoxFit.fill));
  }
}

class _ReproductorVideo extends StatefulWidget {
  final VideoPlayerController controller;
  final bool fullScreamView;
  final bool mostrarAcelerarVideo;
  const _ReproductorVideo(
      {required this.controller,
      this.fullScreamView = false,
      required this.mostrarAcelerarVideo});

  @override
  __ReproductorVideoState createState() => __ReproductorVideoState();
}

class __ReproductorVideoState extends State<_ReproductorVideo> {
  ///Utilizado para cambiar el icono de play y pausa
  bool reproduciendo = false;

  ///True oculta el boton.
  bool ocultarBotonPlayPause = false;

  ///Ultima pausa al video.
  int ultimaPausaVideo = 0;

  ///Diferencia que debe haber con [ultimaPausaVideo] pare volver a ocultar el boton.
  int tiempoOcultarBotonplay = 2;

  bool isShowFullSccream = false;
  bool rotarPantalla = false;
  bool mutearVideo = false;

  @override
  void initState() {
    super.initState();
    isShowFullSccream = widget.fullScreamView;

    widget.controller.addListener(() {
      ///Si se termino de reproducir el video lo reinicia y pausa
      if (widget.controller.value.duration ==
          widget.controller.value.position) {
        if (mounted) {
          setState(() {
            /// La primera vez que ingresa es cuando termina de reproducir el video y lo pone el false primero
            ///asi cuando se ejecute [seekTo] no vuelva a ingresar
            if (reproduciendo) {
              reproduciendo = false;
              widget.controller.seekTo(Duration.zero);
              widget.controller.pause();
            }
          });
        }
      } else {
        reproduciendo = widget.controller.value.isPlaying;
      }

      ///Si el video esta en pausa muestra el boton playPause
      if (!widget.controller.value.isPlaying && mounted) {
        setState(() {
          ocultarBotonPlayPause = false;

          ///[ultimaPausaVideo] tendra el tiempo de reproduccion en segundos al momento de hacer la pausa
          ultimaPausaVideo = widget.controller.value.position.inSeconds;
        });
      }

      ///Ingresa cuando  se este reproduciendo el video y la ultima pausa mas el delay sea mayor al tiempo de reproduccion actual
      else if ((ultimaPausaVideo + tiempoOcultarBotonplay) <
              widget.controller.value.position.inSeconds &&
          mounted) {
        if (!ocultarBotonPlayPause) {
          setState(() => ocultarBotonPlayPause = true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: rotarPantalla ? 1 : 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:

                  /// Cuando se toca en cualquier otra parte del video va a mostrar el boton de playPausa
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          ocultarBotonPlayPause = false;
                          ultimaPausaVideo =
                              widget.controller.value.position.inSeconds;
                        });
                      },
                      child:

                          ///Reproductor de video y progreso de video
                          Stack(alignment: Alignment.bottomCenter, children: [
                        ///ReproductorVideo
                        AspectRatio(
                            aspectRatio: widget.controller.value.aspectRatio,
                            child: VideoPlayer(widget.controller)),

                        ///Barra de progreso y de carga del video
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: VideoProgressIndicator(widget.controller,
                                allowScrubbing: true))
                      ]))),

          ///Pausa o reproduce el video en base al tap en el icono de playPause
          GestureDetector(
              onTap: () {
                setState(() {
                  reproduciendo
                      ? widget.controller.pause()
                      : widget.controller.play();
                });
              },
              child: Opacity(
                opacity: ocultarBotonPlayPause ? 0 : 1,
                child: Icon(
                    reproduciendo
                        ? FontAwesomeIcons.pauseCircle
                        : FontAwesomeIcons.playCircle,
                    color: Colors.blueGrey.withOpacity(0.7),
                    size: size.height * 10 / 100),
              )),

          ///Cambiar a pantalla completa
          Positioned(
              bottom: size.width * 3 / 100,
              right: size.width * 3 / 100,
              child: Opacity(
                opacity: isShowFullSccream ? 0 : 1,
                child: AbsorbPointer(
                  absorbing: isShowFullSccream,
                  child: InkWell(

                      ///Accion a realizar a l pponerse en pantalla completa
                      onTap: () async {},
                      child: Icon(
                        FontAwesomeIcons.expand,
                        color: Colors.blueGrey.withOpacity(0.7),
                        size: size.height * 5 / 100,
                      )),
                ),
              )),

          ///Rotar pantalla
          Positioned(
            top: size.width * 3 / 100,
            right: size.width * 4 / 100,
            child: Opacity(
              opacity: isShowFullSccream ? 1 : 0,
              child: AbsorbPointer(
                absorbing: !isShowFullSccream,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        rotarPantalla = !rotarPantalla;
                      });
                    },
                    child: Icon(
                      Icons.screen_rotation_sharp,
                      color: Colors.blueGrey.withOpacity(0.7),
                      size: size.height * 4 / 100,
                    )),
              ),
            ),
          ),

          ///Velocidad video
          Positioned(
            top: size.width * 14 / 100,
            right: size.width * 3.5 / 100,
            child: Opacity(
              opacity: widget.mostrarAcelerarVideo ? 1.0 : 0.0,
              child: AbsorbPointer(
                absorbing: !widget.mostrarAcelerarVideo,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.controller.setPlaybackSpeed(
                            _cambiarVelocidadReproduccion(
                                widget.controller.value.playbackSpeed));
                      });
                    },
                    child: CirculoWidget(
                        contenidoCirculo: Center(
                            child: Text(
                          '${widget.controller.value.playbackSpeed}',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                        )),
                        sizeCirculo: size.height * 4 / 100,
                        colorCiculo: Colors.blueGrey.withOpacity(0.7))),
              ),
            ),
          ),

          ///Mutear video
          Positioned(
            top: size.width * 14 / 100,
            left: size.width * 3.5 / 100,
            child: Opacity(
              opacity: widget.mostrarAcelerarVideo ? 1.0 : 0.0,
              child: AbsorbPointer(
                absorbing: !widget.mostrarAcelerarVideo,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.controller.setPlaybackSpeed(
                            _cambiarVelocidadReproduccion(
                                widget.controller.value.playbackSpeed));
                      });
                    },
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mutearVideo = !mutearVideo;
                            widget.controller
                                .setVolume(mutearVideo ? 0.0 : 1.0);
                          });
                        },
                        child: Icon(
                          mutearVideo
                              ? Icons.volume_off_outlined
                              : Icons.volume_up_outlined,
                          color: Colors.blueGrey.withOpacity(0.7),
                          size: size.height * 4 / 100,
                        ))),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Cambio de velocidad de reproduccion del video.
  ///Nota se puso hasta 2.0 porque la documentacion da una advertencia con valores superiores para IOS
  double _cambiarVelocidadReproduccion(double velocidadActual) {
    if (velocidadActual == 0.5) {
      return 1.0;
    } else if (velocidadActual == 1.0) {
      return 1.5;
    } else if (velocidadActual == 1.5) {
      return 2.0;
    } else {
      return 0.5;
    }
  }
}

Route _createRoute(BuildContext parentContext, VideoPlayerController video,
    bool mostrarAcelerarVideo) {
  return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
    return _ReproductorPantallaCompleta(
        mostrarAcelerarVideo: mostrarAcelerarVideo, controller: video);
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    var rectAnimation = _createTween(parentContext)
        .chain(CurveTween(curve: Curves.ease))
        .animate(animation);

    ///Se usa un stack para que no produxca un overflow del tamaño del widget en la transicion
    return Stack(children: [
      PositionedTransition(rect: rectAnimation, child: child),
    ]);
  });
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

class _ReproductorPantallaCompleta extends StatefulWidget {
  final VideoPlayerController controller;
  final bool mostrarAcelerarVideo;

  const _ReproductorPantallaCompleta(
      {required this.controller, required this.mostrarAcelerarVideo});

  @override
  __ReproductorPantallaCompletaState createState() =>
      __ReproductorPantallaCompletaState();
}

class __ReproductorPantallaCompletaState
    extends State<_ReproductorPantallaCompleta> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(

            ///TODO accion al ir atras
            onTap: () {
              // navigationService.goBack();
            },
            child: Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                    child: _ReproductorVideo(
                        controller: widget.controller,
                        mostrarAcelerarVideo: widget.mostrarAcelerarVideo,
                        fullScreamView: true)))));
  }
}
