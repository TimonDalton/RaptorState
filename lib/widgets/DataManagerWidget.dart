import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../widgets/InheritedStructure.dart';
import '../models/localRequests.dart';
import 'DataRequestHandler.dart';

class DataManagerWidget<RequestableModel> extends StatefulWidget {
  final DataItemBuilders builders;
  DataItem<RequestableModel> dataItem;
  bool initialised = false;

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
    if (!widget.initialised) {
      Updater updater = Updater<RequestableModel>(
        //setter
        (newVal) {
          setState(() {
            widget.dataItem.valueStore.value = newVal as RequestableModel;
            print(
                'M2 Set State Called: OLD VALUE: ${widget.dataItem.valueStore.value}, NEW VALUE: ${newVal}');
          });
        },
      );
      widget.dataItem.updaters.add(updater);
      bool noError = true;
      if (noError) {
        widget.initialised = true;
      }
    }

    return PathNamingWidget(
      key: UniqueKey(),
      path: PathNamingWidget.of(context) == null
          ? ''
          : PathNamingWidget.of(context)!.path +
              '/' +
              widget.dataItem.internalIdPath,
      child: (widget.dataItem.valueStore.value != null)
          ? widget.builders.dataBuilder(widget.dataItem.valueStore.value)
          : (widget.dataItem.valueStore.rawJson == {})
              ? widget.builders.waitingWidget
              : widget.builders.errorWidget,
    );
  }
}
