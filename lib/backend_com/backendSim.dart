import 'dart:async';
import '../models/dataModels.dart';
import '../models/loadable.dart';
import 'dart:convert';

Map<String, String> UUID_Uri_Map = {};

final dataKept = {
  'M1': {
    'M1_ID_42': {
      'M1_ID_42_child_1': 0,
      'M1_ID_42_child_2': 2,
      'M1_ID_42_child_3': 3,
      'M1_ID_42_child_4': 4,
    },
  },
  'M1_ID_43': {
    'M1_ID_43_child_1': 4,
  },
  'M1_ID_44': {
    'M1_ID_44_child_1': 4,
  },
  'M1_ID_45': {
    'M1_ID_45_child_1': 4,
  },
  'M1_ID_46': {
    'M1_ID_46_child_1': 4,
  },
  'M2_ID_54': '0',
  'M2_ID_55': '0',
  'M2_ID_56': '0',
  'M2_ID_57': '0',
};

int counter = 100;
String generateId() {
  counter++;
  return counter.toString();
}

String backendHttpGet(String req) {
  dynamic ret = {};
  if (req.length == 0) {
    return '';
  }
  if (req[0] == '/') {
    req = req.substring(1);
  }
  List<String> tokens = req.split('/');
  try {
    dynamic curData = dataKept[tokens[0]];
    for (int i = 1; i < tokens.length; i++) {
      if (tokens[i] == '*') {
        return jsonEncode(curData);
      } else {
        curData = curData[tokens[i]]!;
      }
    }
    return curData;
  } catch (e) {
    print('DB Sim Caught error: ');
    print(e);
  }

  return jsonEncode(ret);
}
