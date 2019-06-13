import 'package:flutter/material.dart';

class HJDraggableDemo extends StatefulWidget {
  // 该方法仅为对接个人其它项目使用
  static Map<String, WidgetBuilder> route() {
    return {'/': (BuildContext context) => HJDraggableDemo()};
  }

  @override
  State<StatefulWidget> createState() {
    return _HJDraggableDemoState();
  }
}

class _HJDraggableDemoState extends State<HJDraggableDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Draggable Demo')),
      body: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Draggable简单使用'),
                subtitle: Text('Draggable和DragTarget分开实例'),
                onTap: () {
                  setState(() {});
                },
              ),
            ),
            Card(
                child: ListTile(
              title: Text('可拖拽排序的GridView'),
              subtitle: Text('Draggable和DragTarget组合实例'),
              onTap: () {
                setState(() {
                  Navigator.of(context).pushNamed('/draggable/draggableGrid');
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
