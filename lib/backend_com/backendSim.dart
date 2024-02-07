import 'dart:async';
import 'package:giglee_frontend_state_management_iterations/backend_com/getterService.dart';

import '../models/dataModels.dart';
// import '../models/loadable.dart';
import 'dart:convert';

Map<String, dynamic> UUID_Uri_Map = {};

final dataKept = {
  'M0': {
    'M0_ID_38': {
      'M0_ID_38_child_1': 0,
      'M0_ID_38_child_2': 2,
      'M0_ID_38_child_3': 3,
      'M0_ID_38_child_4': 4,
    },
    'M0_ID_39': {
      'M0_ID_39_child_1': 5,
      'M0_ID_39_child_2': 2,
      'M0_ID_39_child_3': 3,
      'M0_ID_39_child_4': 4,
    },
    'M0_ID_40': {
      'M0_ID_40_child_1': 6,
      'M0_ID_40_child_2': 2,
      'M0_ID_40_child_3': 3,
      'M0_ID_40_child_4': 4,
    },
    'M0_ID_41': {
      'M0_ID_41_child_1': 7,
      'M0_ID_41_child_2': 2,
      'M0_ID_41_child_3': 3,
      'M0_ID_41_child_4': 4,
    },
  },
  'M1': {
    'M1_ID_42': {
      'M1_ID_42_child_1': 0,
      'M1_ID_42_child_2': 2,
      'M1_ID_42_child_3': 3,
      'M1_ID_42_child_4': 4,
    },
  },
  'M2': {
    'M2_ID_54': '1',
    'M2_ID_55': '2',
    'M2_ID_56': '3',
    'M2_ID_57': '4',
  },
};

int counter = 100;
String generateId() {
  counter++;
  return counter.toString();
}

Future<Map<String, dynamic>> backendRequest(String req) async {
  switch (req) {
    case 'M0/*':
      return backendHttpGet('M0');
    case 'M1/*':
      return backendHttpGet('M1');
    case 'M2/*':
      return backendHttpGet('M2');
    default:
      return backendHttpGet(req);
  }
}

Map<String, dynamic> backendHttpGet(String req) {
  print('Processing Req: $req');
  Map<String, dynamic> ret = {};
  if (req.isEmpty) {
    return {};
  }
  if (req[0] == '/') {
    req = req.substring(1);
  }
  List<String> tokens = req.split('/');
  print('Tokens: ${tokens}');
  try {
    print('Kept Data: ');
    print(dataKept);
    dynamic curData = dataKept[tokens[0]];
    print('CurData: ');
    print(curData);
    for (int i = 1; i < tokens.length; i++) {
      if (tokens[i] == '*') {
        return curData;
      } else {
        curData = curData[tokens[i]]!;
      }
    }
    return curData;
  } catch (e) {
    print('DB Sim Caught error: ');
    print(e);
  }

  return ret;
}




// String backendHttpGetRelated(String type, String relation, String? parentPath) {
//   dynamic data = dataKept;
//   data = data[type];
//   if (parentPath != null) {
//     if (parentPath != '') {
//       List<String> tokens = parentPath.split('/');
//       try {
//         for (int i = 0; i < tokens.length; i++) {
//           if (tokens[i] == '*') {
//             break;
//           } else {
//             data = data[tokens[i]]!;
//           }
//         }
//       } catch (e) {
//         print('DB Sim Caught error: ');
//         print(e);
//       }
//     }
//   }
  


// }