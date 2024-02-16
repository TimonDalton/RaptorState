import 'package:flutter/material.dart';
import '../models/dataModels.dart';
import '../models/dataHelper.dart';
import '../models/localRequests.dart';
import '../widgets/InheritedStructure.dart';
import './DataManagerWidget.dart';
import './InheritedStructure.dart';

export './DataManagerWidget.dart';

class DataRequestHandler extends StatefulWidget {
  RequestDataBuilder builders;
  RequestHolder requestHolder;
  DataRequestHandler(
    this.requestHolder,
    this.builders,
  );
  @override
  State<DataRequestHandler> createState() => _DataRequestHandlerState();
}

class _DataRequestHandlerState<T> extends State<DataRequestHandler> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.requestHolder.fetched
        ? widget.builders
            .dataItemListBuilder(widget.requestHolder.getDataItems())
        : FutureBuilder(
            future: widget.requestHolder.fetch(),
            builder: (context, snapshot) {
              print(
                  'Entered DataRequestHandler FutureBuilder for req: ${widget.requestHolder.request}');
              if (snapshot.hasData) {
                print('snapshot.hasData == true');
                return widget.builders
                    .dataItemListBuilder(widget.requestHolder.getDataItems());
              } else if (snapshot.hasError) {
                print('snapshot.hasError == true');
                return widget.builders.errorWidget;
              } else {
                print('snapshot.hasData == false && snapshot.hasData == false');
                return widget.builders.waitingWidget;
              }
            },
          );
  }
}

class DataManagers {
  ///Builds a list of reactive widgets from each of the Ids provided in the given format
  static List<DataManagerWidget> fromIds({
    required List<String> ids,
    required DataItemBuilders builders,
  }) {
    List<DataManagerWidget> ret = [];
    for (int i = 0; i < ids.length; i++) {
      DataItem? di = LocalDataStore.dataItems[ids[i]];
      if (di != null) {
        ret.add(
          DataManagerWidget(
            dataItem: di,
            builders: builders,
          ),
        );
      }
    }
    return ret;
  }

  ///Builds a list of reactive widgets from each of the Ids provided in the given format
  static List<DataManagerWidget> fromDataItems(
    List<DataItem> dis,
    DataItemBuilders builders,
  ) {
    print('In DataManager.fromDataItems');
    List<DataManagerWidget> ret = [];
    for (int i = 0; i < dis.length; i++) {
      ret.add(
        DataManagerWidget(
          dataItem: dis[i],
          builders: builders,
        ),
      );
    }
    return ret;
  }

  ///Builds a list of reactive widgets from each of the Ids provided in the given format
  static List<DataManagerWidget> fromParent(
    BuildContext context,
    DataItemBuilders builders,
  ) {
    if (PathNamingWidget.of(context) == null) {
      return [];
    }
    String parentId = getParentId(context);
    List<DataItem> dataItems = LocalDataStore.dataItems[parentId]!.children;
    return fromDataItems(dataItems, builders);
  }

  // ///Builds a list of reactive widgets which have the same parent in the given format
  // List<DataManagerWidget> dataManagersFromParentQuery<T>({
  //   required BuildContext context,
  //   required String query,
  //   required DataItemBuilders builders,
  //   required RequestableModel Function(Map<String, dynamic>) fromJson,
  // }) {
  //   String parentId = PathNamingWidget.of(context)!.path;
  //   parentId = parentId.split('/').last;
  //   DataItem di = LocalDataStore.dataItems[parentId]!;
  //   String requestQuery = '$parentId/$query';
  //   RequestHolder rh = RequestHolder(requestQuery);
  //   // rh.fetch().then((_) => setState(() {
  //   //       rh.ids = rh.ids;
  //   //     }));
  //   di.childrenRequests.add(rh);
  //   return dataManagersFromIds(ids: rh.ids, builders: builders);
  // }
}
