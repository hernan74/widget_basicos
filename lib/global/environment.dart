class Environment {
  static List<String> rutas = ['walking', 'driving', 'transit', 'bicycling'];

  static String dataErr = 'Error';
  static String dataOk = 'Ok';

  static String opcdef = 'AAA';
  static String opcapp = 'APP';
  static String redFav = 'FAV';

  //Estados app
  static String appDifusa = 'D';
  static String appOculto = 'O';
  static String appVisto = 'V';

  static String tipoLoginTelefono = 'TE';
  static String tipoLoginFacebook = 'FB';
  static String tipoLoginGoogle = 'GO';
  static String tipoLoginApple = 'AP';

  static double latitudOrigen = -26.414541;
  static double longitudOrigen = -54.584995;
  //Acciones en Bloc
  //Bloc Opciones
  static String blocOnObtieneOpciones = 'obt';
  static String blocOnItemActualizadoOpciones = 'dow';
  static String blocOnObtieneAppOpciones = 'app';
  static String blocOnActualizaVistaAppOpciones = 'vista';
  static String blocOnEjecutaAppOpciones = 'ejecutaApp';

  //Bloc Push
  static String blocOnObtienePush = 'obt';
  static String blocOnActualizaPush = 'act';
  //Bloc Mapa
  static String blocOnWifiCercanosMapa = 'wifi';
  static String blocOnEstableceMiUbicacionMapa = 'ubi';
  static String blocOnObtieneRutaMapa = 'rut';
  static String blocOnSeleccionoMenuflotante = 'mapaMenuFlotante';
  static String blocOnSeleccionoMenuRutas = 'mapaMenuRutas';
  static String blocOnDeterminaUbicacionRedFavoriaMapa =
      'determinaUbicacionRedFavorita';
  //Bloc Token
  static String blocOnObtieneCodigoWifiToken = 'codigo';
  static String blocOnGeneraToken = 'token';
  //Bloc HistoriaFavoritos
  static String blocOnObtieneHistoriaFavoritos = 'his';
  static String blocOnObtieneDetalleHistoriaFavoritos = 'det';
  static String blocOnDownLoadImgHistoriaFavoritos = 'dow';
  static String blocOnItemActualizadoHistoriaFavoritos = 'iac';
  static String blocOnFinalizaDownLoadHistoriaFavoritos = 'fin';
  static String blocOnDownLoadVideoHistoriaFavoritos = 'dwv';
  static String blocOnActualizadoHistoriaFavoritos = 'act';
  //Bloc Usuarios
  static String blocOnInicializaUsuario = 'iniUsuario';
  static String blocOnObtieneUsuario = 'obtUsuario';
  static String blocOnLogin = 'login';
  static String blocOnGuradaPreferenciaUsuario = 'GuardaSHP';
  static String blocOnGuardaUsuario = 'GuardaUsuario';
  static String blocOnModificaUsuario = 'ModificaUsuario';
  static String blocOnValidaDatosUsuario = 'ValidaDatosUsurio';
  static String blocOnLogOut = 'GuardaUsuario';
  //Bloc PassWord
  static String blocOnEnviaSMSConCodigo = 'enviaSMS';
  static String blocOnValidaCodigo = 'validaCodigo';
  static String blocOnCambiaPassWord = 'cambiaPassWord';

  // Todo esto hay que actualizar
  //Marandu Conectándonos
  // static String appTitle = 'Marandu\nConectándonos';
  // static String ssid = 'Marandu\nConectándonos';
  // static String url = 'https://marandu.conectwifi.com.ar';
  // static String fireBaseRedes = 'redes_img_marandu';
  // static String fireBaseOpcionesApp = 'app_img_marandu';
  // static String fireBaseArchivos = 'campañas_marandu';
  // static String fireBaseNoticias = 'noticias_marandu';

  //Roble Testeo
  // static String urlApp = 'approble.conectwifi.com.ar';
  static String urlApp = 'appestoyconectado.conectwifi.com.ar';

  static String appTitle = 'Roble\nTesteo';
  static String ssid = 'Roble\nTesteo';
  static String url = 'https://roble.conectwifi.com.ar';
  static String fireBaseRedes = 'redes_img_roble';
  static String fireBaseOpcionesApp = 'app_img_roble';
  static String fireBaseArchivos = 'campañas_roble';
  static String fireBaseNoticias = 'noticias_roble';

  // Estoy Conectado
  // static String appTitle = 'Estoy\nConectado';
  // static String ssid = 'Wifi Gratuito EBY';
  // static String url = 'https://estoyconectado.conectwifi.com.ar';
  // static String fireBaseRedes = 'redes_img_estoyconectado';
  // static String fireBaseOpcionesApp = 'app_img_estoyconectado';
  // static String fireBaseArchivos = 'campañas_estoyconectado';
  // static String fireBaseNoticias = 'noticias_estoyconectado';
  //Hasta aca ===================================

  static String imgSinDownLoad = '#SinDownLoad';
  static String sinImagen = '#SinImagen';
  static const String favTipoContenidoVideo = 'VIDEO';
  static const String favTipoContenidoImgUnica = 'IMAGEN_UNICA';
  static const String favTipoContenidoImgMultiple = 'IMAGEN_MULTIPLE';

  //Carpetas a Crear
  static String folderapp = 'app';
  static String folderNoticias = 'noticias';
  static String folderCamp = 'camp';

  static String dbase = 'Data225Beta.db';
  static String verApp = '40';
  static String tableOpciones = 'Opciones';
  static String tablePush = 'PushNotification';
  static String tableEquipos = 'EquiposWifi';
  static String tableUsuario = 'Usuario';
  static String tableHistoria = 'HistoriaItem';
  static String tableHistoriaDetalle = 'HistoriaDetalle';
  static String tableEstadoHistoria = 'HistoriaItemEstado';

  static String errorHttp = 'http_error';

  ///Logo para la authPage
  static String logoUrl = 'assets/logo.png';
  static String googleMapApiKey = 'AIzaSyAKCrnqxsa0NOO4un1uv4y0Wzs63UGjsxk';
  static String robleApiKey = 'A';
  static String robleTipo = 'desarrollo';
}
