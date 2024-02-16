import './models/localRequests.dart';
import 'dart:io';
import 'dart:ui';

void testScript() async {
  print(
      '-----------------------------------------------------------------------------------------');
  RequestHolder rh = RequestHolder('M2/*');
  await rh.fetch;
  print('ids from rh requesting M2/* ${rh.ids}');

  print(
      '-----------------------------------------------------------------------------------------');
}
