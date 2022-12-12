

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nearby/map_observer.dart';
import 'package:nearby/screens/mapview.dart';

void main() {
  Bloc.observer = MapBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'traveler app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapView(),
    );
  }
}
