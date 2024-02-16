import 'package:flutter/material.dart';
import 'dataHelper.dart';

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

class DataItemBuilders<T> {
  Widget Function(T dataItemValue) dataBuilder;
  Widget waitingWidget;
  Widget errorWidget;

  DataItemBuilders({
    required this.dataBuilder,
    required this.waitingWidget,
    required this.errorWidget,
  });
}

class RequestDataBuilder<T> {
  Widget Function(List<DataItem<T>> dataItemList) dataItemListBuilder;
  Widget waitingWidget;
  Widget errorWidget;

  RequestDataBuilder({
    required this.dataItemListBuilder,
    required this.waitingWidget,
    required this.errorWidget,
  });
}
