import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';

class M2WrappedWidge extends StatefulWidget {
  final M2 m2;
  M2WrappedWidge(this.m2);
  @override
  State<M2WrappedWidge> createState() => _M2WrappedWidgeState();
}

class _M2WrappedWidgeState<T> extends State<M2WrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M2WrappedWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100.00;
    return InkWell(
      onTap: () {
        // LocalDataStore.dataItems.where((item) => false)

        // widget.dataItem!.valueTracker.widgetSetter(M2(
        //     value:
        //         (int.parse(widget.dataItem!.data.value.value) + 1).toString()));
      },
      child: Container(
        width: 8 * vw,
        height: 8 * vw,
        color: Colors.blue,
        child: Text(widget.m2.value),
      ),
    );
  }
}
