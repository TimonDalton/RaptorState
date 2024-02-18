import 'dart:convert';
import 'dart:ffi';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:giglee_frontend_state_management_iterations/backend_com/backendSim.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import 'fromJsonTypeMap.dart';
import './dataModels.dart';
import './localRequests.dart';
import './stringToConstructorTypeMap.dart';

export './localPathId.dart';
export './localRequests.dart';

class DataItem<T> {
  ValueTracker<T> valueTracker = ValueTracker<T>();
  String internalIdPath;
  List<RequestHolder> childrenRequests = [];
  List<DataItem> children = [];

  DataItem({
    required this.internalIdPath,
  });
  T getValue() {
    return valueTracker.value!;
  }

  setData(T newData) {
    valueTracker.updateWithNewValue(newData);
  }

  setWithJson(dynamic json) {
    valueTracker.updateWithJsonData(json);
  }

  String getKey() => internalIdPath.split('/').last;

  pollForNewData() {}

  static DataItem<T> create<T>(String internalIdPath) {
    return DataItem<T>(
      internalIdPath: internalIdPath,
    );
  }
}

class ValueTracker<T> {
  ValueTracker();
  T? value;
  final _controller = StreamController<T>();
  Stream<T> get stream => _controller.stream.asBroadcastStream();

  updateWithNewValue(T data) {
    value = data;
    _controller.sink.add(data);
  }

  updateWithJsonData(dynamic data) {
    print('Decoding Data of type: ${data.runtimeType} with data ${data}');
    T newVal = typeMatchedFromJson(T)(data);
    _controller.sink.add(newVal);
    value = newVal;
  }
}

int counter = 100;
String generateId() {
  counter++;
  return counter.toString();
}

class LocalDataStore {
  static Map<String, DataItem> dataItems = {};
  static DataItem? getDataItem(String key) => dataItems[key];

  static Map<String, String> externalToInternalKeyMap = {};

  static List<String> askServerForChanges() {
    return [];
  }

  static checkAllForChanges() {
    List<String> toChange = askServerForChanges();
  }

  ///ASSUME JSON FORMAT{
  ///  TYPE:...,
  ///  ID: ...,
  ///  VALUE: {...,{ID: ...}}
  ///}
  ///ID+TYPE MEANS NEW DATA-ITEM
  static void digestData(dynamic jsonObj, [RequestHolder? requestHolder]) {
    print('Received Data To Digest: ${jsonObj}');
    if (requestHolder != null) {
      print('From Req: ${requestHolder.request}');
    }
    recursiveDigest(jsonObj, (_) {}, requestHolder);
  }

  static dynamic recursiveDigest(
      dynamic branch, void Function(List<DataItem>) throwChildrenUpTree,
      [RequestHolder? reqHolder]) {
    print(
        'Doing recursiveDigest of ${branch} which has type: ${branch.runtimeType}');
    List<DataItem> newChildren = [];
    //Adds new chldren to this function whenever they are created
    childrenNewDataItemCallback(List<DataItem> dis) {
      newChildren.addAll(dis);
    }

    if (branch is Map<String, dynamic>) {
      print('Branch as Map<String,dynamic>: ${branch}');
      Map<String, dynamic> ret = {};
      List<String> keyList = branch.keys.toList();
      //Add all keys to subbranch, while replacing new dataItems with a reference.
      for (int i = 0; i < keyList.length; i++) {
        String key = keyList[i];
        if (key == 'id' || key == 'type') {
          continue;
        }
        //if submap, search deeper for replacement
        if (branch[key].runtimeType == (Map<String, dynamic>)) {
          ret[key] = recursiveDigest(branch[key], childrenNewDataItemCallback);
        } else if (branch[key].runtimeType == (List<dynamic>)) {
          ret[key] = [];
          for (int subBranchListCount = 0;
              subBranchListCount < branch[key].length;
              subBranchListCount++) {
            ret[key].add(recursiveDigest(
                branch[key][subBranchListCount], childrenNewDataItemCallback));
          }
        } else {
          //else add normal values
          ret[key] = branch[key];
        }
      }
      //check valid format
      assert((keyList.contains('id') && keyList.contains('type')) ||
          !(keyList.contains('id') || keyList.contains('type')));
      //if should be replaced by reference
      if (keyList.contains('id') && keyList.contains('type')) {
        print('Branch contains id and type');
        assert(branch['id'].runtimeType == String);
        String newId = generateId();
        externalToInternalKeyMap[branch['id']] = newId;
        if (reqHolder != null) {
          print('Adding id to reqHolder: ${newId}');
          reqHolder.ids.add(newId);
        }
        dataItems[newId] = createTypedDataItem(branch['type'], newId);
        print('Sending to process Json: ${ret}');
        dataItems[newId]!.setWithJson(ret);
        dataItems[newId]!.children = newChildren;

        throwChildrenUpTree([dataItems[newId]!]);
        return {branch['type']: newId};
      } else {
        throwChildrenUpTree(newChildren);
      }
      return ret;
    } else if (branch.runtimeType == List<dynamic>) {
      print('Branch as List<dynamic>: ${branch}');
      List<dynamic> ret = [];
      for (int i = 0; i < branch.length; i++) {
        ret.add(
            recursiveDigest(branch[i], childrenNewDataItemCallback, reqHolder));
      }
      return ret;
    } else {
      print('Found type of ${branch.runtimeType} for branch, return itself.');
      return branch;
    }
  }
}
