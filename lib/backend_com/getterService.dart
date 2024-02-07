import 'dart:convert';

import 'backendSim.dart';
import '../models/dataModels.dart';

// Future<T> getterService<T>(String id) async {
//   await Future.delayed(Duration(milliseconds: 300));
//   dataKept.
//   return ret!;
// }

// String nestedSearch(String id,Map<String,dynamic> field){
//   if(field.containsKey(id)){
//     return field[id];
//   }else{
//     field.forEach((key, value) {
//       try{
//         final subSearchField = value as Map<String,dynamic>;
//         String? nestedRes = nestedSearch(id,subSearchField[key]);
//       if(nestedRes != ''){
//         return nestedRes;
//       }
//       }catch(e){
//         return '';
//       }
//     });
//     return '';
//   }
// }

Future<Map<String, dynamic>> getM0(String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M0/$id');
  return resp;
}

Future<Map<String, dynamic>> getM0Child(String parent_id, String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M0/$parent_id/$id');
  return resp;
}

Future<Map<String, dynamic>> getAllM0() async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M0');
  return resp;
}

Future<Map<String, dynamic>> getM1(String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M1/$id');
  return resp;
}

Future<Map<String, dynamic>> getM1Child(String parent_id, String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M0/$parent_id/$id');
  return resp;
}

Future<Map<String, dynamic>> getAllM1() async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M1');
  return resp;
}

Future<Map<String, dynamic>> getM2(String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic resp = backendHttpGet('M2/$id');
  return resp;
}

Future<Map<String, dynamic>> getAllM2() async {
  await Future.delayed(Duration(milliseconds: 300));
  dynamic ret = backendHttpGet('M2');
  print('M2 Decoded');
  print(ret);
  return ret;
}
