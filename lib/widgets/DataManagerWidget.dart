import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';
import '../models/localRequests.dart';
import 'DataRequestHandler.dart';

class DataManagerWidget<RequestableModel> extends StatefulWidget {
  final DataItemBuilders builders;
  DataItem<RequestableModel> dataItem;

  DataManagerWidget({
    required this.builders,
    required this.dataItem,
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
    return PathNamingWidget(
      key: UniqueKey(),
      path: PathNamingWidget.of(context) == null
          ? ''
          : PathNamingWidget.of(context)!.path +
              '/' +
              widget.dataItem.internalIdPath,
      child: StreamBuilder(
        stream: widget.dataItem.valueTracker.stream,
        builder: (context, snapshot) {
          print('Stream State of ${widget.dataItem.internalIdPath} ');
          print('');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widget.builders.waitingWidget;
          }
          if (snapshot.hasData) {
            return widget.builders.dataBuilder(widget.dataItem.getValue());
          } else if (snapshot.hasError) {
            return widget.builders.errorWidget;
          }

          return widget.builders.errorWidget;
        },
      ),
      // (widget.dataItem.valueStore.value != null)
      //     ? widget.builders.dataBuilder(widget.dataItem.valueStore.value)
      //     : (widget.dataItem.valueStore.rawJson == {})
      //         ? widget.builders.waitingWidget
      //         : widget.builders.errorWidget,
    );
  }
}
