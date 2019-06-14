import 'package:flutter/material.dart';
import 'package:flutter_draggable/draggable/draggable_demo.dart';
import 'package:flutter_draggable/draggable/draggable_grid_widget.dart';
import 'package:flutter_draggable/draggable/draggable_simple.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: routes()
    );
  }

  Map<String, WidgetBuilder> routes(){
    Map<String, WidgetBuilder> routesMap = Map<String, WidgetBuilder>();
    routesMap.addAll(HJDraggableDemo.route());
    routesMap.addAll(HJDraggableGridWidget.route());
    routesMap.addAll(HJDraggableSimpeDemo.route());
    return routesMap;
  }
}

