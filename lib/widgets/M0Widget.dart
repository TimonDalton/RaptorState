import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';

class M0Widge extends StatefulWidget {
  final M0 m0;
  M0Widge({super.key, required this.m0});

  DataItem? dataItem;
  @override
  State<M0Widge> createState() => _M0WidgeState();
}

class _M0WidgeState<T> extends State<M0Widge> {
  @override
  void initState() {
    super.initState();
    print('top of M0Widge InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem(
          Updater<M0>(
              (newVal) {
                //setter
                setState(() {
                  widget.m0.value = newVal.value;
                });
              },
              M0.fromJson,
              () {
                setState;
              }),
          PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
          ValueStore<M0>(widget.m0));
      print('');
    }
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
      key: UniqueKey(),
      path: widget.dataItem!.internalIdPath,
      child: InkWell(
        onHover: (value) {},
        child: Container(
          width: 36 * vw,
          height: 36 * vw,
          color: Colors.orange,
          child: widget.dataItem != null
              ? Wrap(children: () {
                  List<Widget> res = [];
                  List<M0_Child> items = widget.dataItem!.data.value.value;
                  for (int i = 0; i < items.length; i++) {
                    res.add(M0_ChildWidge(m0_Child: items[i]));
                  }
                  return res;
                }())
              : Text('??'),
        ),
      ),
    );
  }
}

class M0_ChildWidge extends StatefulWidget {
  final M0_Child m0_Child;
  M0_ChildWidge({super.key, required this.m0_Child});

  DataItem? dataItem;
  @override
  State<M0_ChildWidge> createState() => _M0_ChildWidgeState();
}

class _M0_ChildWidgeState<T> extends State<M0_ChildWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M0_ChildWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem(
          Updater<M0_Child>(
              (newVal) {
                //setter
                setState(() {
                  widget.m0_Child.value = newVal.value;
                });
              },
              M0_Child.fromJson,
              () {
                setState;
              }),
          PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
          ValueStore<M0_Child>(widget.m0_Child));
      print('');
    }
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
        key: UniqueKey(),
        path: widget.dataItem!.internalIdPath,
        child: Container(
            color: Colors.green,
            width: 16 * vw,
            height: 16 * vw,
            child: Wrap(children: () {
              List<Widget> subRes = [];
              List<M0_GrandChild> subItems = widget.m0_Child.value;
              for (int j = 0; j < subItems.length; j++) {
                subRes.add(M0_GrandChildWidge(
                  m0_GrandChild: subItems[j],
                ));
              }
              return subRes;
            }())));
  }
}

class M0_GrandChildWidge extends StatefulWidget {
  final M0_GrandChild m0_GrandChild;
  M0_GrandChildWidge({super.key, required this.m0_GrandChild});

  DataItem? dataItem;
  @override
  State<M0_GrandChildWidge> createState() => _M0_GrandChildWidgeState();
}

class _M0_GrandChildWidgeState<T> extends State<M0_GrandChildWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M0_GrandChildWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem(
          Updater<M0_GrandChild>(
              (newVal) {
                //setter
                setState(() {
                  widget.m0_GrandChild.value = newVal.value;
                });
              },
              M0_GrandChild.fromJson,
              () {
                setState;
              }),
          PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
          ValueStore<M0_GrandChild>(widget.m0_GrandChild));
      print('');
    }
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
        key: UniqueKey(),
        path: widget.dataItem!.internalIdPath,
        child: InkWell(
            onTap: () {
              widget.dataItem!.updater.widgetSetter(
                  M0_GrandChild(value: widget.dataItem!.data.value.value + 1));
            },
            child: Container(
                color: Colors.blueGrey,
                width: 8 * vw,
                height: 8 * vw,
                child: Text(widget.m0_GrandChild.value.toString()))));
  }
}
