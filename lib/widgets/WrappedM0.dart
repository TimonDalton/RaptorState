import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/DataManagerWidget.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';
import './DataRequestHandler.dart';

class M0WrappedWidge extends StatefulWidget {
  final M0 m0;
  M0WrappedWidge(this.m0, {super.key});

  @override
  State<M0WrappedWidge> createState() => _M0WrappedWidgeState();
}

class _M0WrappedWidgeState<T> extends State<M0WrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M0WrappedWidge InitState');
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
                    M0_ChildWrappedWidge(dataItemValue),
                waitingWidget: Text('M0Child Waiting'),
                errorWidget: Text('M0Child_Error')),
          ),
        ),
      ),
    );
  }
}

class M0_ChildWrappedWidge extends StatefulWidget {
  final M0_Child m0_child;
  M0_ChildWrappedWidge(this.m0_child, {super.key});

  DataItem? dataItem;
  @override
  State<M0_ChildWrappedWidge> createState() => _M0_ChildWrappedWidgeState();
}

class _M0_ChildWrappedWidgeState<T> extends State<M0_ChildWrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M0_ChildWrappedWidge InitState');
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
        child: Wrap(
          children: DataManagers.fromParent(
            context,
            DataItemBuilders(
                dataBuilder: (dataItemValue) =>
                    M0_GrandchildWrappedWidge(dataItemValue),
                waitingWidget: Text('M0GrandChild Waiting'),
                errorWidget: Text('M0GrandChild_Error')),
          ),
        ),
      ),
    );
  }
}

class M0_GrandchildWrappedWidge extends StatefulWidget {
  final M0_GrandChild m0_grandchild;
  M0_GrandchildWrappedWidge(this.m0_grandchild, {super.key});

  DataItem? dataItem;
  @override
  State<M0_GrandchildWrappedWidge> createState() =>
      _M0_GrandchildWrappedWidgeState();
}

class _M0_GrandchildWrappedWidgeState<T>
    extends State<M0_GrandchildWrappedWidge> {
  @override
  void initState() {
    super.initState();
    print('top of M0_GrandchildWrappedWidge InitState');
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
        width: 4 * vw,
        height: 4 * vw,
        child: Text(
          widget.m0_grandchild.value.toString(),
        ),
      ),
    );
  }
}
