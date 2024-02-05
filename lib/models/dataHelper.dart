import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';

class ValueStore<T> {
  T value;
  ValueStore(this.value);
}

class Updater<T> {
  void Function(dynamic newVal) widgetSetter;
  T Function(String json) fromJson;
  Function() setStateCallback;
  Updater(this.widgetSetter, this.fromJson, this.setStateCallback);
  updateWithData(String json) {
    try {
      T newVal = fromJson(json);
      widgetSetter(newVal);
      setStateCallback();
      print('updateWithData');
    } catch (e) {
      print(
          'Error with dataHelper converting to ${T.toString()} from: $json :::::::: at');
      print(StackTrace.current.toString());
      print(e);
    }
  }
}

class DataItem<T> {
  Updater updater;
  String internalIdPath;
  ValueStore<T> data;

  testPrint() {
    print('-----------------------');
  }

  DataItem(
      {required this.updater,
      required this.internalIdPath,
      required this.data});
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

  static DataItem<T> generateDataItem<T>(
      Updater updater, String internalIdPath, ValueStore<T> data) {
    dataItems.add(DataItem<T>(
        updater: updater, internalIdPath: internalIdPath, data: data));
    return dataItems.last as DataItem<T>;
  }

  static rondomlyChange() async {
    print('dataItems length: ${dataItems.length}');
    if (dataItems.length > 0) {
      dataItems.first.testPrint;
    }
    print('Inside rondomlyChange');
    await Future.delayed(Duration(seconds: 1));
    print('RandomlyChange: 1s wait');

    print('dataItems length: ${dataItems.length}');
    if (dataItems.length > 0) {
      dataItems.first.testPrint;
    }
    print('Testing Normal Functions');
    // print(dataItems[0].runtimeType);
    // print(dataItems[0].updater.runtimeType);
    // print(dataItems[0].updater.widgetSetter.runtimeType);
    // dataItems.first.updater.widgetSetter(M2(value: '22'));
    print(dataItems.first.data.value);
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
