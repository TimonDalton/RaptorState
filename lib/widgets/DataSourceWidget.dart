import 'package:flutter/material.dart';
import '../models/dataHelper.dart';

class DataSourceWidget<T> extends StatefulWidget {
  DataSourceWidget({super.key});
  DataItem? dataItem;
  @override
  State<DataSourceWidget> createState() => _DataSourceWidgetState<T>();
}

class _DataSourceWidgetState<T> extends State<DataSourceWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataItem == null) {
      widget.dataItem = LocalDataStore.generateDataItem(
          Updater((newVal) => null, (json) => null, () => null),
          PathIDGenerator.getNewId(null),
          ValueStore(''));
      print('');
    }
    return Container(color: const Color(0xFFFFE306));
  }
}
