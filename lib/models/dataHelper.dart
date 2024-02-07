import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:giglee_frontend_state_management_iterations/backend_com/backendSim.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import './dataModels.dart';

class ValueStore<RequestableModel> {
  RequestableModel? value;
  ValueStore({this.value});
}

class Updater<T> {
  void Function(dynamic newVal) widgetSetter;
  T Function(Map<String, dynamic> json) fromJson;
  Function() setStateCallback;
  Updater(this.widgetSetter, this.fromJson, this.setStateCallback);
  updateWithData(dynamic data) {
    try {
      if (data is T) {
        widgetSetter(data as T);
        setStateCallback();
        print('updateWithData');
      } else {
        T newVal = fromJson(data);
        widgetSetter(newVal);
        setStateCallback();
      }
    } catch (e) {
      print(
          'Error with dataHelper converting to ${T.toString()} from: $json :::::::: at');
      print(StackTrace.current.toString());
      print(e);
    }
  }
}

enum DataItemState { done, loading, error }

class DataItem<T> {
  Updater updater;
  String internalIdPath;
  ValueStore<T> data;
  InternalRequest resourceRequest;
  DataItemState state = DataItemState.loading;

  void queueForUpdate() async {
    bool hasError = false;
    if (this.resourceRequest.runtimeType == DescribedRequest) {
      DescribedRequest req = resourceRequest as DescribedRequest;
      Map<String, dynamic> data = {};
      try {
        data = await RequestStore.requestData(req.request);
      } catch (e) {
        print('Error at ${StackTrace.current.toString()} of :');
        print(e);
        hasError = true;
      }
      updater.updateWithData(data);
    } else if (this.resourceRequest.runtimeType == IdRequest) {
      IdRequest req = resourceRequest as IdRequest;
      Map<String, dynamic> data = {};
      try {
        data = await RequestStore.requestData(req.id);
      } catch (e) {
        print('Error at ${StackTrace.current.toString()} of :');
        print(e);
        hasError = true;
      }
      updater.updateWithData(data);
    }
    if (hasError) {
      state = DataItemState.error;
    } else {
      state = DataItemState.done;
    }
  }

  DataItem({
    required this.updater,
    required this.internalIdPath,
    required this.data,
    required this.resourceRequest,
  });
}

class StoreItem {
  DataItem data;
  late DateTime lastExternalUpdate;
  late String externalId;
  Map<StoreItem, dynamic> map = {};
  StoreItem(this.data);
}

class LocalDataStore {
  static List<DataItem> dataItems = [];

  static DataItem<T> generateDataItem<T>(Updater updater, String internalIdPath,
      ValueStore<T> data, InternalRequest resourceRequest) {
    dataItems.add(DataItem<T>(
      updater: updater,
      internalIdPath: internalIdPath,
      data: data,
      resourceRequest: resourceRequest,
    ));
    return dataItems.last as DataItem<T>;
  }

  static rondomlyChange() async {
    await Future.delayed(Duration(seconds: 1));

    for (int c = 0; c < 10; c++) {
      await Future.delayed(Duration(milliseconds: 500)).then((value) {
        for (int i = 0; i < dataItems.length; i++) {
          switch (dataItems[i].data.value.runtimeType) {
            case M2:
              String val = dataItems[i].data.value.value as String;
              dataItems[i]
                  .updater
                  .widgetSetter(M2(value: (int.parse(val) + 1).toString()));
              break;
            case M1_Child:
              // int val = dataItems[i].data as int;
              // dataItems[i].updater.widgetSetter(M2(value: (val+1).toString()));
              // int.parse(val);
              break;
            default:
              print('Type: ${dataItems[i].data.value.runtimeType}');
          }
        }
      });
      print('first M2 at ${c.toString()}:');
      print((dataItems
              .where((item) => item.data.value.runtimeType == M2)
              .first
              .data
              .value as M2)
          .value);
    }
  }

  // static registerDataItem(DataItem item) {
  //   item.externalId = asdasdd;
  // }

  // String fetchJson(String path) {}
}

class PathIDGenerator {
  static Map<String, dynamic> registeredItems = {
    'count': 0,
  };
  static String getNewId(String? parentPath) {
    List<String> elements =
        parentPath != null && parentPath != '' ? parentPath.split('/') : [];
    Map<String, dynamic> map = registeredItems;
    if (parentPath != null && parentPath != '') {
      for (int i = 0; i < elements.length - 1; i++) {
        if (map[elements[i]] == null) {
          print('parentPath: ${parentPath}');
        }
        map = map[elements[i]];
      }
    }

    String hash = hashingFunc(map.keys.length);
    map[hash] = Map<String, dynamic>();
    return hash;
  }

  static String hashingFunc(int i) {
    return i.toString();
  }
}

class StateBuilders {
  Widget Function(dynamic data) dataBuilder;
  Widget waitingWidget;
  Widget errorWidget;

  StateBuilders({
    required this.dataBuilder,
    required this.waitingWidget,
    required this.errorWidget,
  });
}

List<String> extractIds(Map<String, dynamic> map) {
  List<String> keys = map.keys.toList();
  List<String> subKeys = [];
  for (int i = 0; i < keys.length; i++) {
    subKeys.addAll(extractIds(map[keys[i]]));
  }
  keys.addAll(subKeys);
  return keys;
}

class RequestStore {
  static Map<String, StoredRequest> storedRequests = {};
  static void initialiseStoredRequests() {}
  static Future<Map<String, dynamic>> requestData(String req) async {
    if (storedRequests[req] != null) {
      return storedRequests[req]!.storedValue;
    }
    Map<String, dynamic> data = await backendRequest(req);

    storedRequests.addAll({
      req: StoredRequest(
        associatedIds: extractIds(data),
        storedValue: data,
      )
    });
    return data;
  }
}

abstract class InternalRequest {
  static DescribedRequest describedRequest(String request, String? parentId) {
    return DescribedRequest(request: request, parentId: parentId);
  }

  static IdRequest idRequest(String id) {
    return IdRequest(id: id);
  }
}

class DescribedRequest implements InternalRequest {
  String? parentId;
  String request;
  DescribedRequest({required this.request, this.parentId});
}

class IdRequest implements InternalRequest {
  String id;
  IdRequest({required this.id});
}

class StoredRequest {
  late DateTime lastUpdated;
  List<String> associatedIds;
  //THIS SHOULD BE REMOVED AND MOVED TO A PERSISTENT DATA STORE AFTER TESTING
  Map<String, dynamic> storedValue;

  StoredRequest(
      {required this.associatedIds,
      this.storedValue = const {},
      DateTime? lastUpdated}) {
    this.lastUpdated = lastUpdated ?? DateTime.now();
  }
}

// class PendingRequest {
//   List<String> associatedIds;
//   PendingRequest({required this.associatedIds});
// }
