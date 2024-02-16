import 'dart:async';
import 'package:giglee_frontend_state_management_iterations/backend_com/getterService.dart';

import '../models/dataModels.dart';
// import '../models/loadable.dart';
import 'dart:convert';
import '../global.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> UUID_Uri_Map = {};

final dataKept = {
  'M0': [
    {
      'type': 'M0',
      'id': 'M0_ID_37',
      'children': [
        {
          'type': 'M0_Child',
          'id': 'M0_Child_ID_38',
          'children': {
            'M0_Child_ID_38_1': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_38_1',
              'value': 0
            },
            'M0_Child_ID_38_2': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_38_2',
              'value': 2
            },
            'M0_Child_ID_38_3': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_38_3',
              'value': 3
            },
            'M0_Child_ID_38_4': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_38_4',
              'value': 4
            },
          },
        },
        {
          'type': 'M0_Child',
          'id': 'M0_Child_ID_39',
          'children': {
            'M0_Child_ID_39_1': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_39_1',
              'value': 10
            },
            'M0_Child_ID_39_2': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_39_2',
              'value': 12
            },
            'M0_Child_ID_39_3': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_39_3',
              'value': 13
            },
            'M0_Child_ID_39_4': {
              'type': 'M0_Grandchild',
              'id': 'M0_Child_ID_39_4',
              'value': 14
            },
          },
        },
      ]
    },
  ],
  'M1': [
    {
      'type': 'M0_Child',
      'id': 'M1_ID_42',
      'children': [
        {'type': 'M1_Child', 'id': 'M1_ID_42_child_1', 'value': 0},
        {'type': 'M1_Child', 'id': 'M1_ID_42_child_2', 'value': 1},
        {'type': 'M1_Child', 'id': 'M1_ID_42_child_3', 'value': 2},
        {'type': 'M1_Child', 'id': 'M1_ID_42_child_4', 'value': 3},
      ],
    },
  ],
  'M2': [
    {
      'type': 'M2',
      'id': 'M2_ID_54',
      'value': '1',
    },
    {
      'type': 'M2',
      'id': 'M2_ID_55',
      'value': '2',
    },
    {
      'type': 'M2',
      'id': 'M2_ID_56',
      'value': '3',
    },
    {
      'type': 'M2',
      'id': 'M2_ID_57',
      'value': '4',
    },
  ],
};

// Future<dynamic> fetchFromBackend() async {}

Future<Map<String, dynamic>> backendRequest(String req) async {
  String requestStr = "${baseUrl}/api/$req";
  print('Request From Frontend: ${requestStr}');
  return backendHttpGet(req);
  var res = await http.get(
    Uri.parse(
      requestStr,
    ),
  );
  if (res.statusCode == 200) {
    // List<dynamic> eventList = jsonToEventObjList(jsonDecode(res.body));
    return json.decode(res.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('"Failed to fetch events error: ${res.statusCode}"');
  }

  // switch (req) {
  //   case 'M0/*':
  //     return backendHttpGet('M0');
  //   case 'M1/*':
  //     return backendHttpGet('M1');
  //   case 'M2/*':
  //     return backendHttpGet('M2');
  //   default:
  //     return backendHttpGet(req);
  // }
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
  // try {
  dynamic curData = dataKept[tokens[0]];
  for (int i = 1; i < tokens.length; i++) {
    if (tokens[i] == '*') {
      return curData;
    } else {
      curData = curData[tokens[i]]!;
    }
  }
  return curData;
  // } catch (e) {
  //   print('DB Sim Caught error: ');
  //   print(e);
  // }
}

Map<String, dynamic> backendGetSpecificKey(String key) {
  return searchKey(key, dataKept);
}

Map<String, dynamic> searchKey(String key, Map<String, dynamic> submap) {
  if (submap.keys.contains(key)) {
    return {key: submap[key]};
  } else {
    for (int i = 0; i < submap.keys.length; i++) {
      Map<String, dynamic> res =
          searchKey(key, submap[submap.keys.toList()[i]]);
      if (res.keys.first == key) {
        return res;
      }
    }
  }
  return {};
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