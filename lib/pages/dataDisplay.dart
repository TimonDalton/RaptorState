import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataHelper.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import 'package:giglee_frontend_state_management_iterations/backend_com/getterService.dart';

class DataDisplay extends StatefulWidget {
  DataDisplay({super.key});
  TextEditingController tec = TextEditingController(text: 'Not Initialised');

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  @override
  void initState() {
    super.initState();
    // print('top of dataDisplay InitState');
    // LocalDataStore.rondomlyChange();
    // Future.delayed(Duration(milliseconds: 1000)).then((value) async {
    //   widget.tec.text = 'Changed';
    //   await Future.delayed(Duration(milliseconds: 1000)).then((value) async {
    //     widget.tec.text = 'M2: ' + (await getAllM2()).values.join(' ');
    //   });
    //   await Future.delayed(Duration(milliseconds: 2000)).then((value) async {
    //     widget.tec.text = 'M1: ' + (await getAllM1()).toString();
    //   });
    //   await Future.delayed(Duration(milliseconds: 3000)).then((value) async {
    //     widget.tec.text = 'M0: ' + (await getAllM0()).toString();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            child: Column(
      children: [
        Text('Eyo'),
        TextField(controller: widget.tec),
      ],
    )));
  }
}
