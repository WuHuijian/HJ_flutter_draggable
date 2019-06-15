import 'package:flutter/material.dart';
import 'dart:math';

class HJDraggableSimpeDemo extends StatefulWidget {
  // 该方法仅为对接个人其它项目使用
  static Map<String, WidgetBuilder> route() {
    return {
      '/draggable/simple': (BuildContext context) => HJDraggableSimpeDemo()
    };
  }

  @override
  State<StatefulWidget> createState() {
    return HJDraggableSimpeDemoState();
  }
}

class HJDraggableSimpeDemoState extends State<HJDraggableSimpeDemo> {
  List<DataBean> _targerDatas;
  DataBean _dragData;

  @override
  void initState() {
    _targerDatas = List<DataBean>();
    _targerDatas.add(DataBean('北', Offset(110, 0), Colors.green));
    _targerDatas.add(DataBean('西', Offset(0, 110), Colors.red));
    _targerDatas.add(DataBean('南', Offset(110, 220), Colors.blue));
    _targerDatas.add(DataBean('东', Offset(220, 110), Colors.purple));
    _dragData = DataBean(randomTitle(), Offset(110, 110), Colors.pink);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Draggable简单使用')),
      body: Center(
          child: Container(
        width: 300,
        height: 300,
        color: Colors.grey,
        child: Stack(
          children: buildItems(_targerDatas, _dragData),
        ),
      )),
    );
  }

  String randomTitle() {
    int i = Random().nextInt(_targerDatas.length);
    return _targerDatas[i].title;
  }

  List<Widget> buildItems(List<DataBean> targetDatas, dragData) {
    List<Widget> items = List<Widget>();
    targetDatas.forEach((data) {
      items.add(dragTarget(data));
    });

    items.add(draggableItem(_dragData));
    return items;
  }

  // 拖动方
  Widget draggableItem(DataBean data) {
    return Positioned(
      left: data.offset.dx,
      top: data.offset.dy,
      child: Draggable(
          data: data,// 要传递的数据
          child: baseItem(data, true),// 要拖动的组件
          feedback: Container(// 移动中的组件
            width: 100,
            height: 100,
            color: data.color.withOpacity(0.8),
            child: Center(
              child: Text('移.动.中',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,decoration: TextDecoration.none)),
            ),
          ),
          childWhenDragging: Container(// 拖动后原位置组件
              width: 80,
              height: 80,
              color: Colors.white),
          onDragStarted: () {// 开始拖动回调
            print('=== onDragStarted');
          },
          // 接收失败回调
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            print('=== onDraggableCanceled');
          },
          onDragCompleted: () {// 接收成功回调
            print('=== onDragCompleted');
          }),
    );
  }

  // 接收方
  Widget dragTarget(DataBean data) {
    return Positioned(
        left: data.offset.dx,
        top: data.offset.dy,
        child: DragTarget(
          //展示的组件
            builder: (context, candidateData, rejectedData) {
              return baseItem(data, false);
            },
            //返回是否接收 参数为Draggable的data 方向相同则允许接收
            onWillAccept: (DataBean acceptData) {
              print('=== onWillAccept: ' + acceptData.title + '==>' + data.title);
              return acceptData.title.compareTo(data.title) == 0;
            },
            onAccept: (DataBean acceptData) {//接收方法
              print('=== onAccept: ' + acceptData.title + '==>' + data.title);
              setState(() {//修改数据进行重绘
                // 交换颜色 并生成随机方向
                var index = _targerDatas.indexOf(data);
                var tmpColor = data.color;
                data.color = acceptData.color;
                _targerDatas.remove(data);
                _targerDatas.insert(index, data);
                _dragData.title = randomTitle();
                _dragData.color = tmpColor;
              });
            },
            onLeave: (DataBean acceptData) {// 经过然后离开回调
              print('=== onLeave: ' + acceptData.title + '==>' + data.title);
            }));
  }

  // 基础Widgit
  Widget baseItem(data, draggable) {
    String title = draggable ? '往\"'+data.title+'\"走' : data.title;
    return Container(
      width: 80,
      height: 80,
      color: data.color,
      child: Center(
        child: Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
  }
}
// 要传递的数据
class DataBean {
  String title;
  Offset offset;
  Color color;
  DataBean(this.title, this.offset, this.color);
}
