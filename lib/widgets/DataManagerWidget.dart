import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';

class DataManagerWidget<RequestableModel> extends StatefulWidget {
  final StateBuilders builders;
  final RequestableModel Function(Map<String, dynamic>) fromJson;
  late DataItem<RequestableModel> dataItem;
  bool initialised = false;
  InternalRequest request;

  DataManagerWidget({
    required this.request,
    required this.builders,
    required this.fromJson,
  });
  @override
  State<DataManagerWidget<RequestableModel>> createState() =>
      _DataManagerWidgetState();
}

class _DataManagerWidgetState<RequestableModel>
    extends State<DataManagerWidget<RequestableModel>> {
  @override
  void initState() {
    super.initState();
    print('top of DataManagerWidget InitState');
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.initialised) {
      widget.initialised = true;
      widget.dataItem = LocalDataStore.generateDataItem<RequestableModel>(
        Updater<RequestableModel>(
            //setter
            (newVal) {
              setState(() {
                widget.dataItem.data.value = newVal.value as RequestableModel;
                print(
                    'M2 Set State Called: OLD VALUE: ${widget.dataItem.data.value}, NEW VALUE: ${newVal.value}');
              });
            },
            //fromJSON
            widget.fromJson,
            //setStateCallback
            () {
              setState;
            }),
        // PathIDGenerator.getNewId(null),
        PathIDGenerator.getNewId(PathNamingWidget.of(context)!.path),
        ValueStore(),
        widget.request,
      );
      widget.dataItem.queueForUpdate();
    }

    return PathNamingWidget(
      key: UniqueKey(),
      path: widget.dataItem.internalIdPath,
      child: (widget.dataItem.state == DataItemState.done)
          ? widget.builders.dataBuilder(widget.dataItem.data.value)
          : (widget.dataItem.state == DataItemState.loading)
              ? widget.builders.waitingWidget
              : widget.builders.errorWidget,
    );
  }
}
