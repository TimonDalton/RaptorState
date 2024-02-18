import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/DataManagerWidget.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';
import './DataRequestHandler.dart';

class M1WrappedWidge extends StatefulWidget {
  final M1 m1;
  M1WrappedWidge(this.m1, {super.key});

  @override
  State<M1WrappedWidge> createState() => _M1WrappedWidgeState();
}

class _M1WrappedWidgeState<T> extends State<M1WrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M1WrappedWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100.00;
    return InkWell(
      onTap: () {},
      child: Container(
        width: 18 * vw,
        height: 18 * vw,
        color: Colors.red,
        child: Wrap(
          children: DataManagers.fromParent(
            context,
            DataItemBuilders(
                dataBuilder: (dataItemValue) =>
                    M1_ChildWrappedWidge(dataItemValue),
                waitingWidget: Text('M1Child Waiting'),
                errorWidget: Text('M1Child_Error')),
          ),
        ),
      ),
    );
  }
}

class M1_ChildWrappedWidge extends StatefulWidget {
  final M1_Child m1_child;
  M1_ChildWrappedWidge(this.m1_child, {super.key});

  DataItem? dataItem;
  @override
  State<M1_ChildWrappedWidge> createState() => _M1_ChildWrappedWidgeState();
}

class _M1_ChildWrappedWidgeState<T> extends State<M1_ChildWrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M1_ChildWrappedWidge InitState');
  }

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100.00;
    DataItem thisDi = LocalDataStore.dataItems[getParentId(context)]!;
    return InkWell(
      onTap: () {
        thisDi.setData(thisDi.valueStore.value + 1);
      },
      child: Container(
        color: Colors.blueGrey,
        width: 8 * vw,
        height: 8 * vw,
        child: Text(
          widget.m1_child.value.toString(),
        ),
      ),
    );
  }
}
