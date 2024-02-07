import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';

class M1Widge extends StatefulWidget {
  final M1 m1;
  M1Widge({super.key, required this.m1});

  DataItem? dataItem;
  @override
  State<M1Widge> createState() => _M1WidgeState();
}

class _M1WidgeState<T> extends State<M1Widge> {
  @override
  void initState() {
    super.initState();
    print('top of M1Widge InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem(
        Updater<M1>(
            (newVal) {
              //setter
              setState(() {
                widget.m1.value = newVal.value;
              });
            },
            M1.fromJson,
            () {
              setState;
            }),
        PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
        ValueStore<M1>(value: widget.m1),
        IdRequest(id: ''),
      );
      print('');
    }
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
      key: UniqueKey(),
      path: widget.dataItem!.internalIdPath,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 18 * vw,
          height: 18 * vw,
          color: Colors.red,
          child: widget.dataItem != null
              ? Wrap(
                  children: (BuildContext context) {
                    List<Widget> res = [];
                    List<M1_Child> items = widget.dataItem!.data.value.value;
                    for (int i = 0; i < items.length; i++) {
                      res.add(
                        M1_ChildWidge(
                          m1_child: items[i],
                        ),
                      );
                    }
                    return res;
                  }(context),
                )
              : Text('??'),
        ),
      ),
    );
  }
}

class M1_ChildWidge extends StatefulWidget {
  final M1_Child m1_child;
  M1_ChildWidge({super.key, required this.m1_child});

  DataItem? dataItem;
  @override
  State<M1_ChildWidge> createState() => _M1_ChildWidgeState();
}

class _M1_ChildWidgeState<T> extends State<M1_ChildWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M1_ChildWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    widget.dataItem = LocalDataStore.generateDataItem(
      Updater<M1_Child>(
          (newVal) {
            //setter
            setState(() {
              widget.m1_child.value = newVal.value;
            });
          },
          M1_Child.fromJson,
          () {
            setState;
          }),
      PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
      ValueStore<M1_Child>(value: widget.m1_child),
      IdRequest(id: ''),
    );
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
        key: UniqueKey(),
        path: widget.dataItem!.internalIdPath,
        child: InkWell(
            onTap: () {
              widget.dataItem!.updater.widgetSetter(
                  M1_Child(value: widget.dataItem!.data.value.value + 1));
            },
            child: Container(
                color: Colors.blueGrey,
                width: 8 * vw,
                height: 8 * vw,
                child: Text(widget.m1_child.value.toString()))));
  }
}
