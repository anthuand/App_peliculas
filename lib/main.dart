import 'package:flutter/material.dart';
import 'package:i_movie/src/page/home_page.dart';
import 'package:i_movie/src/page/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImoVies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetallePage(),
      },
    );
  }
}
