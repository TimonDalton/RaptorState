import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';

class M2Widge extends StatefulWidget {
  final M2 m2;
  M2Widge({required this.m2});
  DataItem<M2>? dataItem;
  @override
  State<M2Widge> createState() => _M2WidgeState();
}

class _M2WidgeState<T> extends State<M2Widge> {
  @override
  void initState() {
    super.initState();
    print('top of M2Widge InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem<M2>(
        Updater<M2>(
            //setter
            (newVal) {
              print('setter called');
              setState(() {
                widget.dataItem!.data.value!.value = newVal.value;
                print(
                    'M2 Set State Called: OLD VALUE: ${widget.dataItem!.data.value!.value}, NEW VALUE: ${newVal.value}');
              });
            },
            //fromJSON
            M2.fromJson,
            //setStateCallback
            () {
              setState;
            }),
        // PathIDGenerator.getNewId(null),
        PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
        ValueStore(value: widget.m2),
        IdRequest(id: ''),
      );
      print('');
    }
    double vw = MediaQuery.of(context).size.width / 100.00;
    return PathNamingWidget(
      key: UniqueKey(),
      path: widget.dataItem!.internalIdPath,
      child: InkWell(
        onTap: () {
          // LocalDataStore.dataItems.where((item) => false)
          widget.dataItem!.updater.widgetSetter(M2(
              value: (int.parse(widget.dataItem!.data.value!.value) + 1)
                  .toString()));
        },
        child: Container(
          width: 8 * vw,
          height: 8 * vw,
          color: Colors.blue,
          child: widget.dataItem != null
              ? Text(widget.dataItem!.data.value!.value)
              : Text('??'),
        ),
      ),
    );
  }
}
