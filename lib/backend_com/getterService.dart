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

Future<M1> getM1(String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  String resp = backendHttpGet('M1/$id');
  return M1(value: []);
}

Future<M2> getM1Child(String parent_id, String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  String resp = backendHttpGet('M2/$parent_id/$id');
  return M2.fromJson(resp);
}

Future<M2> getM2(String id) async {
  await Future.delayed(Duration(milliseconds: 300));
  String resp = backendHttpGet('M2/$id');
  return M2.fromJson(resp);
}
