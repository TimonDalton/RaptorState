import './models/localRequests.dart';
import './models/dataHelper.dart';
import './models/dataModels.dart';
import 'dart:io';
import 'dart:ui';

void testScript() async {
  print(
      '-----------------------------------------------------------------------------------------');
  List<String> keys = [];
  // RequestHolder rhm2 = RequestHolder('M2/*');
  // await rhm2.fetch();
  // print('ids from rh requesting M2/* ${rhm2.ids}');
  // keys = LocalDataStore.dataItems.keys.toList();
  // print('LocalDataStore Key length: ${keys.length}');
  // print('DataItems');
  // keys.forEach(
  //     (key) => print((LocalDataStore.dataItems[key]!.valueStore.value).value));
  // RequestHolder rhm1 = RequestHolder('M1/*');
  // await rhm1.fetch();
  // print('ids from rh requesting M1/* ${rhm1.ids}');
  // keys = LocalDataStore.dataItems.keys.toList();
  // print('LocalDataStore Key length: ${keys.length}');
  // keys.forEach((key) =>
  //     print((LocalDataStore.dataItems[key]!.valueTracker.value).value));
  RequestHolder rhm0 = RequestHolder('M0/*');
  await rhm0.fetch();
  print('ids from rh requesting M0/* ${rhm0.ids}');
  keys = LocalDataStore.dataItems.keys.toList();
  print('LocalDataStore Key length: ${keys.length}');
  keys.forEach((key) => print((LocalDataStore.dataItems[key]!.getValue())));

  print(
      '-----------------------------------------------------------------------------------------');
}
